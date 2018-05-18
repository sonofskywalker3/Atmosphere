SUBFOLDERS_NODEPS := exosphere/bpmpfw stratosphere thermosphere
SUBFOLDERS := exosphere fusee $(SUBFOLDERS_NODEPS)

TOPTARGETS := all clean

all: $(SUBFOLDERS)
clean:
	@$(MAKE) -C exosphere/bpmpfw clean
	@$(MAKE) -C exosphere clean
	@$(MAKE) -C stratosphere clean
	@$(MAKE) -C thermosphere clean
	@$(MAKE) -C fusee clean

$(SUBFOLDERS_NODEPS):
	@$(MAKE) -C $@ all

exosphere: exosphere/bpmpfw
	@mkdir -p exosphere/components
	@cp exosphere/bpmpfw/bpmpfw.bin exosphere/components
	@$(MAKE) -C $@ all

KIPS := \
	stratosphere/loader/loader.kip \
	stratosphere/pm/pm.kip \
	stratosphere/sm/sm.kip \
	stratosphere/boot/boot_100.kip stratosphere/boot/boot_200.kip

fusee: exosphere thermosphere stratosphere
	@mkdir -p fusee/fusee-secondary/components
	@cp exosphere/exosphere.bin thermosphere/thermosphere.bin $(KIPS) fusee/fusee-secondary/components
	@$(MAKE) -C $@ all


.PHONY: $(TOPTARGETS) $(SUBFOLDERS)
