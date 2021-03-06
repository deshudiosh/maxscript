try (destroyDialog PGShowHideMaps) catch()

rollout PGShowHideMaps "PG Show/Hide Maps" width:200 (
	fn getMtls = (for obj in selection where (obj.material != undefined) collect obj.material)
	
	fn makevisible mtls bool = (
		for mtl in mtls do (
			try (
				case (classof mtl) of (
					Multimaterial: makevisible mtl.materialList bool
					VRay2SidedMtl: (
						showTextureMap mtl mtl.frontMtl bool
						showTextureMap mtl mtl.backMtl bool
					)
					RS_Material: (
						showTextureMap mtl mtl.diffuse_color_map bool
					)
					default: (
						showTextureMap mtl bool
					)
				)
			) catch ()
		)
	)
	
	fn reloadBitmaps = (
		fn GetBitmapTextures theObjects =
		(
			texMaps = #()
			for obj in theObjects do
			(
				join texMaps (getClassInstances bitmapTexture target:obj asTrackViewPick:off)
			)
			makeUniqueArray texMaps
		)
		texMaps = (GetBitmapTextures selection)
		for texMap in texMaps do (
			texMap.reload()
		)
	)	
	
	button showBtn "Show" across:2 width:80
	button hideBtn "Hide" width:80
	button reloadBtn "Reload" width:80
	
	fn click bool = (
		mtls = getMtls()
		makevisible mtls bool
	)
	
	on showBtn pressed do click True
	on hideBtn pressed do click False
	on reloadBtn pressed do reloadBitmaps()
)

clearlistener()
createDialog PGShowHideMaps