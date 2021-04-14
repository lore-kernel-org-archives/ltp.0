From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Apr 2021 17:39:08 +0200
Subject: [LTP] [PATCH v3 3/7] Add new CGroups APIs
In-Reply-To: <20210412145506.26894-4-rpalethorpe@suse.com>
References: <20210412145506.26894-1-rpalethorpe@suse.com>
 <20210412145506.26894-4-rpalethorpe@suse.com>
Message-ID: <YHcMnBaznFaBPj2U@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Complete rewrite of the CGroups API which provides two layers of
> indirection between the test author and the SUT's CGroup
> configuration.

I've spend quite some time reading the code and I think that the
generall idea and implementation is good.

There is quite a bit of minor details that I think may be done better,
see comments.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  include/tst_cgroup.h |  194 ++++++-
>  include/tst_test.h   |    1 -
>  lib/Makefile         |    2 +
>  lib/tst_cgroup.c     | 1205 +++++++++++++++++++++++++++++++-----------
>  4 files changed, 1056 insertions(+), 346 deletions(-)
> 
> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
> index bfd848260..d6842d641 100644
> --- a/include/tst_cgroup.h
> +++ b/include/tst_cgroup.h
> @@ -2,46 +2,194 @@
>  /*
>   * Copyright (c) 2020 Red Hat, Inc.
>   * Copyright (c) 2020 Li Wang <liwang@redhat.com>
> + * Copyright (c) 2020-2021 SUSE LLC <rpalethorpe@suse.com>
>   */
> +/*\
> + * [DESCRIPTION]
> + *
> + * The LTP CGroups API tries to present a consistent interface to the
> + * many possible CGroup configurations a system could have.
> + *
> + * You may ask; "Why don't you just mount a simple CGroup hierarchy,
> + * instead of scanning the current setup?". The short answer is that
> + * it is not possible unless no CGroups are currently active and
> + * almost all of our users will have CGroups active. Even if
> + * unmounting the current CGroup hierarchy is a reasonable thing to do
> + * to the sytem manager, it is highly unlikely the CGroup hierarchy
> + * will be destroyed. So users would be forced to remove their CGroup
> + * configuration and reboot the system.
> + *
> + * The core library tries to ensure an LTP CGroup exists on each
> + * hierarchy root. Inside the LTP group it ensures a 'drain' group
> + * exists and creats a test group for the current test. In the worst
> + * case we end up with a set of hierarchies like the follwoing. Where
> + * existing system-manager-created CGroups have been omitted.
> + *
> + * 	(V2 Root)	(V1 Root 1)	...	(V1 Root N)
> + * 	    |		     |			     |
> + *	  (ltp)		   (ltp)	...	   (ltp)
> + *	 /     \	  /	\		  /	\
> + *  (drain) (test-n) (drain)  (test-n)  ...  (drain)  (test-n)
> + *
> + * V2 CGroup controllers use a single unified hierarchy on a single
> + * root. Two or more V1 controllers may share a root or have their own
> + * root. However there may exist only one instance of a controller.
> + * So you can not have the same V1 controller on multiple roots.
> + *
> + * It is possible to have both a V2 hierarchy and V1 hierarchies
> + * active at the same time. Which is what is shown above. Any
> + * controllers attached to V1 hierarchies will not be available in the
> + * V2 hierarchy. The reverse is also true.
> + *
> + * Note that a single hierarchy may be mounted multiple
> + * times. Allowing it to be accessed at different locations. However
> + * subsequent mount operations will fail if the mount options are
> + * different from the first.
> + *
> + * The user may pre-create the CGroup hierarchies and the ltp CGroup,
> + * otherwise the library will try to create them. If the ltp group
> + * already exists and has appropriate permissions, then admin
> + * privileges will not be required to run the tests.
> + *
> + * Because the test may not have access to the CGroup root(s), the
> + * drain CGroup is created. This can be used to store processes which
> + * would otherwise block the destruction of the individual test CGroup
> + * or one of its descendants.
> + *
> + * The test author may create child CGroups within the test CGroup
> + * using the CGroup Item API. The library will create the new CGroup
> + * in all the relevant hierarchies.
> + *
> + * There are many differences between the V1 and V2 CGroup APIs. If a
> + * controller is on both V1 and V2, it may have different parameters
> + * and control files. Some of these control files have a different
> + * name, but similar functionality. In this case the Item API uses
> + * the V2 names and aliases them to the V1 name when appropriate.
> + *
> + * Some control files only exist on one of the versions or they can be
> + * missing due to other reasons. The Item API allows the user to check
> + * if the file exists before trying to use it.
> + *
> + * Often a control file has almost the same functionality between V1
> + * and V2. Which means it can be used in the same way most of the
> + * time, but not all. For now this is handled by exposing the API
> + * version a controller is using to allow the test author to handle
> + * edge cases. (e.g. V2 memory.swap.max accepts "max", but V1
> + * memory.memsw.limit_in_bytes does not).
> +\*/
>  
>  #ifndef TST_CGROUP_H
>  #define TST_CGROUP_H
>  
> -#define PATH_TMP_CG_MEM	"/tmp/cgroup_mem"
> -#define PATH_TMP_CG_CST	"/tmp/cgroup_cst"
> -
> +/* CGroups Kernel API version */
>  enum tst_cgroup_ver {
>  	TST_CGROUP_V1 = 1,
>  	TST_CGROUP_V2 = 2,
>  };
>  
> -enum tst_cgroup_ctrl {
> -	TST_CGROUP_MEMCG = 1,
> +/* Controller sub-systems */
> +enum tst_cgroup_css {
> +	TST_CGROUP_MEMORY = 1,
>  	TST_CGROUP_CPUSET = 2,
> -	/* add cgroup controller */
>  };

I spend a bit of time figuring out what css means, can't we just use
controler in the code instead? It's a bit longer but more obvious.

Or is this consitent with kernel naming?

> +#define TST_CGROUP_MAX TST_CGROUP_CPUSET
> +
> +/* At most we can have one cgroup V1 tree for each controller and one
> + * (empty) v2 tree.
> + */
> +#define TST_CGROUP_MAX_TREES (TST_CGROUP_MAX + 1)
> +
> +
> +/* Used to specify CGroup hierarchy configuration options, allowing a
> + * test to request a particular CGroup structure.
> + */
> +struct tst_cgroup_opts {
> +	/* Only try to mount V1 CGroup controllers. This will not
> +	 * prevent V2 from being used if it is already mounted, it
> +	 * only indicates that we should mount V1 controllers if
> +	 * nothing is present. By default we try to mount V2 first. */
> +	int only_mount_v1:1;
> +};

Do we need to pass the flags in a structure?

This is not an API that has to be future proof, when we find out we need
more than a few bitflags we can always change it.

> +struct tst_cgroup_tree;
> +
> +
> +/* A Control Group in LTP's aggregated hierarchy */
> +struct tst_cgroup {
> +	const char *name;
> +	/* Maps controller ID to the tree which contains it. The V2
> +	 * tree is at zero even if it contains no controllers.
> +	 */
> +	struct tst_cgroup_tree *trees_by_css[TST_CGROUP_MAX_TREES];
> +	/* NULL terminated list of trees */
> +	struct tst_cgroup_tree *trees[TST_CGROUP_MAX_TREES + 1];
> +};

So this is an array of directories in different trees, can we please
name the strucuture better. What about tst_cgroup_nodes or
tst_cgroup_dirs?

> +/* Search the system for mounted cgroups and available
> + * controllers. Called automatically by tst_cgroup_require.
> + */
> +void tst_cgroup_scan(void);
> +/* Print the config detected by tst_cgroup_scan */
> +void tst_cgroup_print_config(void);
> +
> +/* Ensure the specified controller is available in the test's default
> + * CGroup, mounting/enabling it if necessary */
> +void tst_cgroup_require(enum tst_cgroup_css type,
> +			const struct tst_cgroup_opts *options);

This is the only function in the API that uses the enum cgroup_css. I
think that it may as well be better if we just passed a string to this
function as well and made the enum strictly internal.

I guess that we do not want to split the knob names so that we would
have to pass the controller as enum and knob name to make the API
consistently use the enum so this would be a better option.

> +/* Tear down any CGroups created by calls to tst_cgroup_require */
> +void tst_cgroup_cleanup(void);
> +
> +/* Get the default CGroup for the test. It allocates memory (in a
> + * guarded buffer) so should always be called from setup
> + */
> +const struct tst_cgroup *tst_cgroup_get_test(void);
> +/* Get the shared drain group. Also should be called from setup */
> +const struct tst_cgroup *tst_cgroup_get_drain(void);

I think that these functions could be named better, it's mildly
confusing, "get test what?".

Maybe tst_cgroup_get_test_group() ?

Or tst_cgroup_get(enum tst_cgroup_group group) ?

> +/* Create a descendant CGroup */
> +struct tst_cgroup *tst_cgroup_mk(const struct tst_cgroup *parent,
> +				 const char *name);

The name parameter should probably be called node_name or dir_name, it
could be easily confused with the name parameter rest of the function
use to describe a "controller.knob" pair.

> +/* Remove a descendant CGroup */
> +struct tst_cgroup *tst_cgroup_rm(struct tst_cgroup *cg);
> +
> +#define SAFE_CGROUP_VER(cg, name) \
> +	safe_cgroup_ver(__FILE__, __LINE__, (cg), (name))

> +enum tst_cgroup_ver safe_cgroup_ver(const char *file, const int lineno,
> +				    const struct tst_cgroup *cg,
> +				    const char *name);

The 'name' parameter should really be controller_name or just
controller.

Also I was a bit confused why version request may even fail.

I guess that it's fine if we tst_brk() on invalid controller name even
without calling this function SAFE_*.

We haven't defined that anywhere but SAFE_FUNCTIONS() are things that
may fail at runtime because of failures propagated from the operating
system itself.

> +#define SAFE_CGROUP_HAS(cg, name) \
> +	safe_cgroup_has(__FILE__, __LINE__, (cg), (name))
> +
> +int safe_cgroup_has(const char *file, const int lineno,
> +		    const struct tst_cgroup *cg, const char *name);
> +
> +#define SAFE_CGROUP_READ(cg, name, out, len)				\
> +	safe_cgroup_read(__FILE__, __LINE__, (cg), (name), (out), (len))
> +
> +ssize_t safe_cgroup_read(const char *file, const int lineno,
> +			 const struct tst_cgroup *cg, const char *name,
> +			 char *out, size_t len);
>  
> -enum tst_cgroup_ver tst_cgroup_version(void);
> +#define SAFE_CGROUP_PRINTF(cg, name, fmt, ...)				\
> +	safe_cgroup_printf(__FILE__, __LINE__, (cg), (name), (fmt), __VA_ARGS__)
>  
> -/* To mount/umount specified cgroup controller on 'cgroup_dir' path */
> -void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const char *cgroup_dir);
> -void tst_cgroup_umount(const char *cgroup_dir);
> +#define SAFE_CGROUP_PRINT(cg, name, str)				\
> +	safe_cgroup_printf(__FILE__, __LINE__, (cg), (name), "%s", (str))
>  
> -/* To move current process PID to the mounted cgroup tasks */
> -void tst_cgroup_move_current(const char *cgroup_dir);
> +void safe_cgroup_printf(const char *file, const int lineno,
> +			const struct tst_cgroup *cg, const char *name,
> +			const char *fmt, ...)
> +			__attribute__ ((format (printf, 5, 6)));
>  
> -/* To set cgroup controller knob with new value */
> -void tst_cgroup_set_knob(const char *cgroup_dir, const char *knob, long value);
> +#define SAFE_CGROUP_SCANF(cg, name, fmt, ...)				\
> +	safe_cgroup_scanf(__FILE__, __LINE__, (cg), (name), (fmt), __VA_ARGS__)
>  
> -/* Set of functions to set knobs under the memory controller */
> -void tst_cgroup_mem_set_maxbytes(const char *cgroup_dir, long memsz);
> -int  tst_cgroup_mem_swapacct_enabled(const char *cgroup_dir);
> -void tst_cgroup_mem_set_maxswap(const char *cgroup_dir, long memsz);
> +void safe_cgroup_scanf(const char *file, const int lineno,
> +		       const struct tst_cgroup *cg, const char *name,
> +		       const char *fmt, ...)
> +		       __attribute__ ((format (scanf, 5, 6)));

And for all the read/printf/scanf functions the name parameter should be
named knob or something that describes that we are operating on
individual files in a directory somewhere in the tree.

> -/* Set of functions to read/write cpuset controller files content */
> -void tst_cgroup_cpuset_read_files(const char *cgroup_dir, const char *filename,
> -	char *retbuf, size_t retbuf_sz);
> -void tst_cgroup_cpuset_write_files(const char *cgroup_dir, const char *filename,
> -	const char *buf);
>  
>  #endif /* TST_CGROUP_H */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 1fbebe752..62ab2981f 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -39,7 +39,6 @@
>  #include "tst_capability.h"
>  #include "tst_hugepage.h"
>  #include "tst_assert.h"
> -#include "tst_cgroup.h"
>  #include "tst_lockdown.h"
>  #include "tst_fips.h"
>  #include "tst_taint.h"
> diff --git a/lib/Makefile b/lib/Makefile
> index f019432e8..6f641ee9a 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -38,6 +38,8 @@ pc_file			:= $(DESTDIR)/$(datarootdir)/pkgconfig/ltp.pc
>  
>  INSTALL_TARGETS		:= $(pc_file)
>  
> +tst_cgroup.o: CFLAGS += -Wno-missing-field-initializers

I'm not sure we want to work around warnings like this.

>  $(pc_file):
>  	test -d "$(@D)" || mkdir -p "$(@D)"
>  	install -m $(INSTALL_MODE) "$(builddir)/$(@F)" "$@"
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 96c9524d2..40c9a9bec 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -2,453 +2,1014 @@
>  /*
>   * Copyright (c) 2020 Red Hat, Inc.
>   * Copyright (c) 2020 Li Wang <liwang@redhat.com>
> + * Copyright (c) 2020-2021 SUSE LLC <rpalethorpe@suse.com>
>   */
>  
>  #define TST_NO_DEFAULT_MAIN
>  
>  #include <stdio.h>
> +#include <stddef.h>
>  #include <stdlib.h>
> +#include <mntent.h>
>  #include <sys/mount.h>
> -#include <fcntl.h>
> -#include <unistd.h>
>  
>  #include "tst_test.h"
> -#include "tst_safe_macros.h"
> -#include "tst_safe_stdio.h"
> +#include "lapi/fcntl.h"
> +#include "lapi/mount.h"
> +#include "lapi/mkdirat.h"
>  #include "tst_cgroup.h"
> -#include "tst_device.h"
>  
> -static enum tst_cgroup_ver tst_cg_ver;
> -static int clone_children;
> +/* CGroup Core Implementation
> + *
> + * CGroup Item Implementation is towards the bottom.
> + */
>  
> -static int tst_cgroup_check(const char *cgroup)
> -{
> -	char line[PATH_MAX];
> -	FILE *file;
> -	int cg_check = 0;
> +struct cgroup_root;
>  
> -	file = SAFE_FOPEN("/proc/filesystems", "r");
> -	while (fgets(line, sizeof(line), file)) {
> -		if (strstr(line, cgroup) != NULL) {
> -			cg_check = 1;
> -			break;
> +/* A node in a single CGroup hierarchy. It exists mainly for
> + * convenience so that we do not have to traverse the CGroup structure
> + * for frequent operations.
> + *
> + * This is actually a single-linked list not a tree. We only need to
> + * traverse from leaf towards root.
> + */
> +struct tst_cgroup_tree {

Why isn't this called node or dir? Either of these would be more
fitting.

Also the tst_cgroup structure could use a better name, the tst_cgroup is
actually an array of pointers to directories.

> +	const char *name;

This should be dir_name, can we please avoid having all string pointers
called just 'name' I find it horribly confusing...

> +	const struct tst_cgroup_tree *parent;
> +
> +	/* Shortcut to root */
> +	const struct cgroup_root *root;
> +
> +	/* Subsystems (controllers) bit field. Only controllers which
> +	 * were required and configured for this node are added to
> +	 * this field. So it may be different from root->css_field.
> +	 */
> +	uint32_t css_field;
> +
> +	/* In general we avoid having sprintfs everywhere and use
> +	 * openat, linkat, etc.
> +	 */
> +	int dir;

Can we name this dir_fd so it's obvious what it is?

> +	int we_created_it:1;
> +};
> +
> +/* The root of a CGroup hierarchy/tree */
> +struct cgroup_root {
> +	enum tst_cgroup_ver ver;
> +	/* A mount path */
> +	char path[PATH_MAX/2];

Why PATH_MAX/2 ?

Also why don't we call it mount_path[] instead of having a lousy comment
that people have to look up when reading code?

> +	/* Subsystems (controllers) bit field. Includes all
> +	 * controllers found while scanningthis root.
> +	 */
> +	uint32_t css_field;
> +
> +	/* CGroup hierarchy: mnt -> ltp -> {drain, test -> ??? } We
> +	 * keep a flat reference to ltp, drain and test for
> +	 * convenience.
> +	 */
> +
> +	/* Mount directory */
> +	struct tst_cgroup_tree mnt;
> +	/* LTP CGroup directory, contains drain and test dirs */
> +	struct tst_cgroup_tree ltp;
> +	/* Drain CGroup, see cgroup_cleanup */
> +	struct tst_cgroup_tree drain;
> +	/* CGroup for current test. Which may have children. */
> +	struct tst_cgroup_tree test;

Here as well, it's sligtly easier to understand if we suffix the names
with what it actually is. If we rename struct tst_cgroup_tree to
tst_cgroup_node this should be ltp_node, drain_node, etc.

> +	int we_mounted_it:1;
> +	/* cpuset is in compatability mode */
> +	int no_prefix:1;
> +};
> +
> +/* Always use first item for unified hierarchy */
> +struct cgroup_root roots[TST_CGROUP_MAX_TREES + 1];
> +
> +/* Describes some things that are part of a CGroup
> + *
> + * Usually trunk nodes are controllers and leaves are files exported
> + * by the controllers. Sometimes trunk nodes are components of a
> + * controller (e.g. memory.swap).
> + *
> + * The primary purpose of this is to map V2 names to V1
> + * names. Secondarily we can map name prefixes to controller IDs and
> + * figure out which hierarchy the item should be present on and
> + * whether the current configuration requires yet further work arounds
> + * (e.g. if cpuset is mounted in compatablity mode).
> + */
> +struct cgroup_item {
> +	/* Canonical name. Is the V2 name unless an item is V1 only */
> +	const char *name;
> +	/* V1 name or NULL if item is V2 only */
> +	const char *name_v1;
> +	/* Array of child items or NULL */
> +	struct cgroup_item *inner;
> +
> +	/* The controller this item belongs to or zero for
> +	 * 'cgroup.<item>'. Leaf items are statically initialised as
> +	 * zero then set at runtime.
> +	 */
> +	enum tst_cgroup_css css_indx;
> +
> +	struct cgroup_root *root;
> +
> +	int we_require_it:1;
> +};
> +
> +/* Lookup tree for item names. */
> +typedef struct cgroup_item items_t[];
> +static items_t items = {
> +	[0] = { "cgroup", .inner = (items_t){
> +			{ "cgroup.procs", "tasks" },
> +			{ "cgroup.subtree_control" },
> +			{ "cgroup.clone_children", "clone_children" },
> +			{ NULL }
>  		}
> -	}
> -	SAFE_FCLOSE(file);
> +	},
> +	[TST_CGROUP_MEMORY] = { "memory", .inner = (items_t){
> +			{ "memory.current", "memory.usage_in_bytes" },
> +			{ "memory.max", "memory.limit_in_bytes" },
> +			{ "memory.swappiness", "memory.swappiness" },
> +			{ "memory.swap.current", "memory.memsw.usage_in_bytes" },
> +			{ "memory.swap.max", "memory.memsw.limit_in_bytes" },
> +			{ "memory.kmem.usage_in_bytes", "memory.kmem.usage_in_bytes" },
> +			{ "memory.kmem.limit_in_bytes", "memory.kmem.usage_in_bytes" },
> +			{ NULL }
> +		},
> +	  .css_indx = TST_CGROUP_MEMORY
> +	},
> +	[TST_CGROUP_CPUSET] = { "cpuset", .inner = (items_t){
> +			{ "cpuset.cpus", "cpuset.cpus" },
> +			{ "cpuset.mems", "cpuset.mems" },
> +			{ "cpuset.memory_migrate", "cpuset.memory_migrate" },
> +			{ NULL }
> +		},
> +	  .css_indx = TST_CGROUP_CPUSET
> +	},
> +	{ NULL }
> +};

Item is a very generic word, this is a list of known knobs and map
between v1 and v2. So maybe cgroup_knob_map or just cgroup_knobs ?

-- 
Cyril Hrubis
chrubis@suse.cz
