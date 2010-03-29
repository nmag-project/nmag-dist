
LIBPARMETIS=libparmetis__SHLIB_SUFFIX__

../$(LIBPARMETIS):
	$(CC) __SHARED__ $(OBJS) -L__INSTALL_PATH__/ -lmetis -o __INSTALL_PATH__/$(LIBPARMETIS)

shlib: ../$(LIBPARMETIS)

.PHONY: shlib
