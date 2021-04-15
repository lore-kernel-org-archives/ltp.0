From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 15 Apr 2021 14:10:00 +0100
Subject: [LTP] [PATCH v3 3/7] Add new CGroups APIs
In-Reply-To: <YHcMnBaznFaBPj2U@yuki>
References: <20210412145506.26894-1-rpalethorpe@suse.com>
 <20210412145506.26894-4-rpalethorpe@suse.com> <YHcMnBaznFaBPj2U@yuki>
Message-ID: <875z0n3d93.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> Complete rewrite of the CGroups API which provides two layers of
>> indirection between the test author and the SUT's CGroup
>> configuration.
>
> I've spend quite some time reading the code and I think that the
> generall idea and implementation is good.
>
> There is quite a bit of minor details that I think may be done better,
> see comments.

Thanks for the review.
>>  
>> -#define PATH_TMP_CG_MEM	"/tmp/cgroup_mem"
>> -#define PATH_TMP_CG_CST	"/tmp/cgroup_cst"
>> -
>> +/* CGroups Kernel API version */
>>  enum tst_cgroup_ver {
>>  	TST_CGROUP_V1 = 1,
>>  	TST_CGROUP_V2 = 2,
>>  };
>>  
>> -enum tst_cgroup_ctrl {
>> -	TST_CGROUP_MEMCG = 1,
>> +/* Controller sub-systems */
>> +enum tst_cgroup_css {
>> +	TST_CGROUP_MEMORY = 1,
>>  	TST_CGROUP_CPUSET = 2,
>> -	/* add cgroup controller */
>>  };
>
> I spend a bit of time figuring out what css means, can't we just use
> controler in the code instead? It's a bit longer but more obvious.
>
> Or is this consitent with kernel naming?

The kernel seems to refer to controllers as subsystems and css appears
to mean "CGroup subsystem". I'm not sure if subsystems are necessarily
controllers, but it seems that way. Also "controller" has too many
letters in it. Indeed it makes some function names very long and I found
that harder to read.

I suppose to be totally consistent with the kernel we should randomly
name some things css and others subsys. :-p

>
>> +#define TST_CGROUP_MAX TST_CGROUP_CPUSET
>> +
>> +/* At most we can have one cgroup V1 tree for each controller and one
>> + * (empty) v2 tree.
>> + */
>> +#define TST_CGROUP_MAX_TREES (TST_CGROUP_MAX + 1)
>> +
>> +
>> +/* Used to specify CGroup hierarchy configuration options, allowing a
>> + * test to request a particular CGroup structure.
>> + */
>> +struct tst_cgroup_opts {
>> +	/* Only try to mount V1 CGroup controllers. This will not
>> +	 * prevent V2 from being used if it is already mounted, it
>> +	 * only indicates that we should mount V1 controllers if
>> +	 * nothing is present. By default we try to mount V2 first. */
>> +	int only_mount_v1:1;
>> +};
>
> Do we need to pass the flags in a structure?
>
> This is not an API that has to be future proof, when we find out we need
> more than a few bitflags we can always change it.

We may need to add xattr to this and there are many other
options. However most tests will just have NULL or 0, 0... So we could
move it into a vararg or have a tst_require2?

>
>> +struct tst_cgroup_tree;
>> +
>> +
>> +/* A Control Group in LTP's aggregated hierarchy */
>> +struct tst_cgroup {
>> +	const char *name;
>> +	/* Maps controller ID to the tree which contains it. The V2
>> +	 * tree is at zero even if it contains no controllers.
>> +	 */
>> +	struct tst_cgroup_tree *trees_by_css[TST_CGROUP_MAX_TREES];
>> +	/* NULL terminated list of trees */
>> +	struct tst_cgroup_tree *trees[TST_CGROUP_MAX_TREES + 1];
>> +};
>
> So this is an array of directories in different trees, can we please
> name the strucuture better. What about tst_cgroup_nodes or
> tst_cgroup_dirs?

I guess tst_cgroup_tree always represents a directory. So I would go
with tst_cgroup_dir.

>
>> +/* Search the system for mounted cgroups and available
>> + * controllers. Called automatically by tst_cgroup_require.
>> + */
>> +void tst_cgroup_scan(void);
>> +/* Print the config detected by tst_cgroup_scan */
>> +void tst_cgroup_print_config(void);
>> +
>> +/* Ensure the specified controller is available in the test's default
>> + * CGroup, mounting/enabling it if necessary */
>> +void tst_cgroup_require(enum tst_cgroup_css type,
>> +			const struct tst_cgroup_opts *options);
>
> This is the only function in the API that uses the enum cgroup_css. I
> think that it may as well be better if we just passed a string to this
> function as well and made the enum strictly internal.
>
> I guess that we do not want to split the knob names so that we would
> have to pass the controller as enum and knob name to make the API
> consistently use the enum so this would be a better option.

+1

>
>> +/* Tear down any CGroups created by calls to tst_cgroup_require */
>> +void tst_cgroup_cleanup(void);
>> +
>> +/* Get the default CGroup for the test. It allocates memory (in a
>> + * guarded buffer) so should always be called from setup
>> + */
>> +const struct tst_cgroup *tst_cgroup_get_test(void);
>> +/* Get the shared drain group. Also should be called from setup */
>> +const struct tst_cgroup *tst_cgroup_get_drain(void);
>
> I think that these functions could be named better, it's mildly
> confusing, "get test what?".
>
> Maybe tst_cgroup_get_test_group() ?

+1

>
> Or tst_cgroup_get(enum tst_cgroup_group group) ?
>
>> +/* Create a descendant CGroup */
>> +struct tst_cgroup *tst_cgroup_mk(const struct tst_cgroup *parent,
>> +				 const char *name);
>
> The name parameter should probably be called node_name or dir_name, it
> could be easily confused with the name parameter rest of the function
> use to describe a "controller.knob" pair.

+1

>
>> +/* Remove a descendant CGroup */
>> +struct tst_cgroup *tst_cgroup_rm(struct tst_cgroup *cg);
>> +
>> +#define SAFE_CGROUP_VER(cg, name) \
>> +	safe_cgroup_ver(__FILE__, __LINE__, (cg), (name))
>
>> +enum tst_cgroup_ver safe_cgroup_ver(const char *file, const int lineno,
>> +				    const struct tst_cgroup *cg,
>> +				    const char *name);
>
> The 'name' parameter should really be controller_name or just
> controller.
>
> Also I was a bit confused why version request may even fail.
>
> I guess that it's fine if we tst_brk() on invalid controller name even
> without calling this function SAFE_*.
>
> We haven't defined that anywhere but SAFE_FUNCTIONS() are things that
> may fail at runtime because of failures propagated from the operating
> system itself.

+1
>
>> +#define SAFE_CGROUP_HAS(cg, name) \
>> +	safe_cgroup_has(__FILE__, __LINE__, (cg), (name))
>> +
>> +int safe_cgroup_has(const char *file, const int lineno,
>> +		    const struct tst_cgroup *cg, const char *name);
>> +
>> +#define SAFE_CGROUP_READ(cg, name, out, len)				\
>> +	safe_cgroup_read(__FILE__, __LINE__, (cg), (name), (out), (len))
>> +
>> +ssize_t safe_cgroup_read(const char *file, const int lineno,
>> +			 const struct tst_cgroup *cg, const char *name,
>> +			 char *out, size_t len);
>>  
>> -enum tst_cgroup_ver tst_cgroup_version(void);
>> +#define SAFE_CGROUP_PRINTF(cg, name, fmt, ...)				\
>> +	safe_cgroup_printf(__FILE__, __LINE__, (cg), (name), (fmt), __VA_ARGS__)
>>  
>> -/* To mount/umount specified cgroup controller on 'cgroup_dir' path */
>> -void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const char *cgroup_dir);
>> -void tst_cgroup_umount(const char *cgroup_dir);
>> +#define SAFE_CGROUP_PRINT(cg, name, str)				\
>> +	safe_cgroup_printf(__FILE__, __LINE__, (cg), (name), "%s", (str))
>>  
>> -/* To move current process PID to the mounted cgroup tasks */
>> -void tst_cgroup_move_current(const char *cgroup_dir);
>> +void safe_cgroup_printf(const char *file, const int lineno,
>> +			const struct tst_cgroup *cg, const char *name,
>> +			const char *fmt, ...)
>> +			__attribute__ ((format (printf, 5, 6)));
>>  
>> -/* To set cgroup controller knob with new value */
>> -void tst_cgroup_set_knob(const char *cgroup_dir, const char *knob, long value);
>> +#define SAFE_CGROUP_SCANF(cg, name, fmt, ...)				\
>> +	safe_cgroup_scanf(__FILE__, __LINE__, (cg), (name), (fmt), __VA_ARGS__)
>>  
>> -/* Set of functions to set knobs under the memory controller */
>> -void tst_cgroup_mem_set_maxbytes(const char *cgroup_dir, long memsz);
>> -int  tst_cgroup_mem_swapacct_enabled(const char *cgroup_dir);
>> -void tst_cgroup_mem_set_maxswap(const char *cgroup_dir, long memsz);
>> +void safe_cgroup_scanf(const char *file, const int lineno,
>> +		       const struct tst_cgroup *cg, const char *name,
>> +		       const char *fmt, ...)
>> +		       __attribute__ ((format (scanf, 5, 6)));
>
> And for all the read/printf/scanf functions the name parameter should be
> named knob or something that describes that we are operating on
> individual files in a directory somewhere in the tree.

+1

>
>> -/* Set of functions to read/write cpuset controller files content */
>> -void tst_cgroup_cpuset_read_files(const char *cgroup_dir, const char *filename,
>> -	char *retbuf, size_t retbuf_sz);
>> -void tst_cgroup_cpuset_write_files(const char *cgroup_dir, const char *filename,
>> -	const char *buf);
>>  
>>  #endif /* TST_CGROUP_H */
>> diff --git a/include/tst_test.h b/include/tst_test.h
>> index 1fbebe752..62ab2981f 100644
>> --- a/include/tst_test.h
>> +++ b/include/tst_test.h
>> @@ -39,7 +39,6 @@
>>  #include "tst_capability.h"
>>  #include "tst_hugepage.h"
>>  #include "tst_assert.h"
>> -#include "tst_cgroup.h"
>>  #include "tst_lockdown.h"
>>  #include "tst_fips.h"
>>  #include "tst_taint.h"
>> diff --git a/lib/Makefile b/lib/Makefile
>> index f019432e8..6f641ee9a 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -38,6 +38,8 @@ pc_file			:= $(DESTDIR)/$(datarootdir)/pkgconfig/ltp.pc
>>  
>>  INSTALL_TARGETS		:= $(pc_file)
>>  
>> +tst_cgroup.o: CFLAGS += -Wno-missing-field-initializers
>
> I'm not sure we want to work around warnings like this.

I suppose this is a result of cgroup_item being overly generic.

>
>>  $(pc_file):
>>  	test -d "$(@D)" || mkdir -p "$(@D)"
>>  	install -m $(INSTALL_MODE) "$(builddir)/$(@F)" "$@"
>> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
>> index 96c9524d2..40c9a9bec 100644
>> --- a/lib/tst_cgroup.c
>> +++ b/lib/tst_cgroup.c
>> @@ -2,453 +2,1014 @@
>>  /*
>>   * Copyright (c) 2020 Red Hat, Inc.
>>   * Copyright (c) 2020 Li Wang <liwang@redhat.com>
>> + * Copyright (c) 2020-2021 SUSE LLC <rpalethorpe@suse.com>
>>   */
>>  
>>  #define TST_NO_DEFAULT_MAIN
>>  
>>  #include <stdio.h>
>> +#include <stddef.h>
>>  #include <stdlib.h>
>> +#include <mntent.h>
>>  #include <sys/mount.h>
>> -#include <fcntl.h>
>> -#include <unistd.h>
>>  
>>  #include "tst_test.h"
>> -#include "tst_safe_macros.h"
>> -#include "tst_safe_stdio.h"
>> +#include "lapi/fcntl.h"
>> +#include "lapi/mount.h"
>> +#include "lapi/mkdirat.h"
>>  #include "tst_cgroup.h"
>> -#include "tst_device.h"
>>  
>> -static enum tst_cgroup_ver tst_cg_ver;
>> -static int clone_children;
>> +/* CGroup Core Implementation
>> + *
>> + * CGroup Item Implementation is towards the bottom.
>> + */
>>  
>> -static int tst_cgroup_check(const char *cgroup)
>> -{
>> -	char line[PATH_MAX];
>> -	FILE *file;
>> -	int cg_check = 0;
>> +struct cgroup_root;
>>  
>> -	file = SAFE_FOPEN("/proc/filesystems", "r");
>> -	while (fgets(line, sizeof(line), file)) {
>> -		if (strstr(line, cgroup) != NULL) {
>> -			cg_check = 1;
>> -			break;
>> +/* A node in a single CGroup hierarchy. It exists mainly for
>> + * convenience so that we do not have to traverse the CGroup structure
>> + * for frequent operations.
>> + *
>> + * This is actually a single-linked list not a tree. We only need to
>> + * traverse from leaf towards root.
>> + */
>> +struct tst_cgroup_tree {
>
> Why isn't this called node or dir? Either of these would be more
> fitting.
>
> Also the tst_cgroup structure could use a better name, the tst_cgroup is
> actually an array of pointers to directories.

As far as the test author is concerned it represents an actual "Control
Group". We keep arrays of directories to join together multiple V1
controllers on different hierarchies, but that is an implementation
detail.

If anything it should be called tst_cgroup_group, but I don't like the
repetition. :-p

>
>> +	const char *name;
>
> This should be dir_name, can we please avoid having all string pointers
> called just 'name' I find it horribly confusing...
>
>> +	const struct tst_cgroup_tree *parent;
>> +
>> +	/* Shortcut to root */
>> +	const struct cgroup_root *root;
>> +
>> +	/* Subsystems (controllers) bit field. Only controllers which
>> +	 * were required and configured for this node are added to
>> +	 * this field. So it may be different from root->css_field.
>> +	 */
>> +	uint32_t css_field;
>> +
>> +	/* In general we avoid having sprintfs everywhere and use
>> +	 * openat, linkat, etc.
>> +	 */
>> +	int dir;
>
> Can we name this dir_fd so it's obvious what it is?
>
>> +	int we_created_it:1;
>> +};
>> +
>> +/* The root of a CGroup hierarchy/tree */
>> +struct cgroup_root {
>> +	enum tst_cgroup_ver ver;
>> +	/* A mount path */
>> +	char path[PATH_MAX/2];
>
> Why PATH_MAX/2 ?

This was to prevent static anlyses warnings with sprintf IIRC. It can
not be PATH_MAX unless the mount point contents are only expected to be
accessed with openat. I suppose that since I removed the sprintfs we can
use the full PATH_MAX to be consistent.

>> +/* Lookup tree for item names. */
>> +typedef struct cgroup_item items_t[];
>> +static items_t items = {
>> +	[0] = { "cgroup", .inner = (items_t){
>> +			{ "cgroup.procs", "tasks" },
>> +			{ "cgroup.subtree_control" },
>> +			{ "cgroup.clone_children", "clone_children" },
>> +			{ NULL }
>>  		}
>> -	}
>> -	SAFE_FCLOSE(file);
>> +	},
>> +	[TST_CGROUP_MEMORY] = { "memory", .inner = (items_t){
>> +			{ "memory.current", "memory.usage_in_bytes" },
>> +			{ "memory.max", "memory.limit_in_bytes" },
>> +			{ "memory.swappiness", "memory.swappiness" },
>> +			{ "memory.swap.current", "memory.memsw.usage_in_bytes" },
>> +			{ "memory.swap.max", "memory.memsw.limit_in_bytes" },
>> +			{ "memory.kmem.usage_in_bytes", "memory.kmem.usage_in_bytes" },
>> +			{ "memory.kmem.limit_in_bytes", "memory.kmem.usage_in_bytes" },
>> +			{ NULL }
>> +		},
>> +	  .css_indx = TST_CGROUP_MEMORY
>> +	},
>> +	[TST_CGROUP_CPUSET] = { "cpuset", .inner = (items_t){
>> +			{ "cpuset.cpus", "cpuset.cpus" },
>> +			{ "cpuset.mems", "cpuset.mems" },
>> +			{ "cpuset.memory_migrate", "cpuset.memory_migrate" },
>> +			{ NULL }
>> +		},
>> +	  .css_indx = TST_CGROUP_CPUSET
>> +	},
>> +	{ NULL }
>> +};
>
> Item is a very generic word, this is a list of known knobs and map
> between v1 and v2. So maybe cgroup_knob_map or just cgroup_knobs ?

I suppose that cgroup_item can be seperated into just two structs now
that I removed controller sub items like "memory.swap". This might help
solve the missing initializer warnings as well.

I would not describe "memory.current" as a knob. It is a read only file
and I think of knobs as something you can write to. So I would prefer
cgroup_file and cgroup_subsys.

-- 
Thank you,
Richard.
