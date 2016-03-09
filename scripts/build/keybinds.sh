# Install key bindings

get_keybinds_dir() {
	echo "$(get_lnp_dir)/LNP/Keybinds"
}

# Download
do_keybinds_get() {
	if [ "${CT_KEYBINDS_VERSION}" = "" ]; then
		export CT_KEYBINDS_VERSION="${CT_KEYBINDS_REV}"
	fi
	url="https://raw.githubusercontent.com/Lazy-Newb-Pack/LNP-shared-core/master/keybinds/"
    # Keybinds set from Github repo 'Lazy-Newb-Pack/LNP-shared-core'
	for kb in Classic_LNP New_LNP PeridexisErrant; do
		CT_GetFile ${kb} ".txt" ${url}
	done
}

# Extract
do_keybinds_extract() {
	# Nothing to do
	echo -n
}

# Build
do_keybinds_build() {
	# copy to dir LNP/Keybinds
	for kb in Classic_LNP New_LNP PeridexisErrant; do
		CT_DoExecLog ALL cp -f "${CT_TARBALLS_DIR}/${kb}.txt" "$(get_keybinds_dir)/"
	done
	# backup vanilla keybinds
	CT_DoExecLog ALL cp -f "$(get_df_dir)/data/init/interface.txt" "$(get_keybinds_dir)/Vanilla_DF.txt"
}
