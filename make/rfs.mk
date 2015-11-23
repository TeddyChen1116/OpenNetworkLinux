############################################################
#
# Common rules for invoking the onlrfs script.
#
# See $(ONL)/tools/onlrfs.py
#
############################################################

ifndef ARCH
$(error $$ARCH must be specified)
endif

ifndef RFS_CONFIG
$(error $$RFS_CONFIG must be set to the RFS yaml configuration file)
endif

ifndef RFS_DIR
$(error $$RFS_DIR must be set)
endif

RFS_COMMAND := $(ONL)/tools/onlrfs.py --arch $(ARCH) --config $(RFS_CONFIG) --dir $(RFS_DIR)

ifdef RFS_CPIO
RFS_COMMAND += --cpio $(RFS_CPIO)
endif

ifdef RFS_SQUASH
RFS_COMMAND += --squash $(RFS_SQUASH)
endif

RFS:
	$(ONL_V_at) rm -rf manifest.json
	$(ONL_V_at) $(RFS_COMMAND)
	$(ONL_V_at) [ -f $(RFS_DIR)/etc/onl/rootfs/manifest.json ] && cp $(RFS_DIR)/etc/onl/rootfs/manifest.json .

clean:
	$(ONL_V_at) sudo rm -rf $(RFS_DIR)
	$(ONL_v_at) rm -rf $(RFS_CPIO) $(RFS_SQUASH)


show-packages:
	$(ONL_V_at) $(RFS_COMMAND) --show-packages