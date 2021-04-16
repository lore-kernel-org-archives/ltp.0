From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Apr 2021 13:00:13 +0800
Subject: [LTP] [PATCH v3 3/7] Add new CGroups APIs
In-Reply-To: <875z0n3d93.fsf@suse.de>
References: <20210412145506.26894-1-rpalethorpe@suse.com>
 <20210412145506.26894-4-rpalethorpe@suse.com>
 <YHcMnBaznFaBPj2U@yuki> <875z0n3d93.fsf@suse.de>
Message-ID: <CAEemH2fWB7KcXbT-4OVE7WfCfkVA2_k9-dW+CXTKgh5aTtETFQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

>> -enum tst_cgroup_ctrl {
> >> -    TST_CGROUP_MEMCG = 1,
> >> +/* Controller sub-systems */
> >> +enum tst_cgroup_css {
> >> +    TST_CGROUP_MEMORY = 1,
> >>      TST_CGROUP_CPUSET = 2,
> >> -    /* add cgroup controller */
> >>  };
> >
> > I spend a bit of time figuring out what css means, can't we just use
> > controler in the code instead? It's a bit longer but more obvious.
> >
> > Or is this consitent with kernel naming?
>
> The kernel seems to refer to controllers as subsystems and css appears
> to mean "CGroup subsystem". I'm not sure if subsystems are necessarily
> controllers, but it seems that way. Also "controller" has too many
> letters in it. Indeed it makes some function names very long and I found
> that harder to read.


I also feel css looks oddly, if "controller" is too long we can go back
with "ctrl",
then we might need a one-line comment for the name abbreviation.

e.g.  previous "/* add cgroup controller */" is make no sense but a hint
for people
to know this is cgroup controller and could be extended in the future.


> I suppose to be totally consistent with the kernel we should randomly
> name some things css and others subsys. :-p
>

Not very necessary, this test API is facing for userland,
understanding easily
for users is more important I think.


>> +struct tst_cgroup_opts {
> >> +    /* Only try to mount V1 CGroup controllers. This will not
> >> +     * prevent V2 from being used if it is already mounted, it
> >> +     * only indicates that we should mount V1 controllers if
> >> +     * nothing is present. By default we try to mount V2 first. */
> >> +    int only_mount_v1:1;
> >> +};
> >
> > Do we need to pass the flags in a structure?
> >
> > This is not an API that has to be future proof, when we find out we need
> > more than a few bitflags we can always change it.
>
> We may need to add xattr to this and there are many other
> options. However most tests will just have NULL or 0, 0... So we could
> move it into a vararg or have a tst_require2?
>

My 2cent:

I slightly think tst_cgroup_opts is good stuff, it gives a possibility
to let users hook the cgoup mount way or, more options they
needed (maybe for customized users). And, in most situations
that test just has NULL, that's fine.

@Richard,
do you want to reserve the ?no_cleanup? in this structure as well?
I noticed you leave it in tst_cgroup02 test.



> >> +    struct tst_cgroup_tree *trees[TST_CGROUP_MAX_TREES + 1];
> >> +};
> >
> > So this is an array of directories in different trees, can we please
> > name the strucuture better. What about tst_cgroup_nodes or
> > tst_cgroup_dirs?
>
> I guess tst_cgroup_tree always represents a directory. So I would go
> with tst_cgroup_dir.
>

+1

>> +struct tst_cgroup_tree {
> >
> > Why isn't this called node or dir? Either of these would be more
> > fitting.
> >
> > Also the tst_cgroup structure could use a better name, the tst_cgroup is
> > actually an array of pointers to directories.
>
> As far as the test author is concerned it represents an actual "Control
> Group". We keep arrays of directories to join together multiple V1
> controllers on different hierarchies, but that is an implementation
> detail.
>
> If anything it should be called tst_cgroup_group, but I don't like the
> repetition. :-p
>

Personally, I think tst_cgroup_node may be better since we have described
a tree for cgroup.  root, node, and leaves(files) should be more vivid.


>> +
> >> +    /* In general we avoid having sprintfs everywhere and use
> >> +     * openat, linkat, etc.
> >> +     */
> >> +    int dir;
> >
> > Can we name this dir_fd so it's obvious what it is?
>

+1
I stand by Cyril at this point.


>> +/* Lookup tree for item names. */
> >> +typedef struct cgroup_item items_t[];
> >> +static items_t items = {
> >> +    [0] = { "cgroup", .inner = (items_t){
> >> +                    { "cgroup.procs", "tasks" },
> >> +                    { "cgroup.subtree_control" },
> >> +                    { "cgroup.clone_children", "clone_children" },
> >> +                    { NULL }
> >>              }
> >> -    }
> >> -    SAFE_FCLOSE(file);
> >> +    },
> >> +    [TST_CGROUP_MEMORY] = { "memory", .inner = (items_t){
> >> +                    { "memory.current", "memory.usage_in_bytes" },
> >> +                    { "memory.max", "memory.limit_in_bytes" },
> >> +                    { "memory.swappiness", "memory.swappiness" },
> >> +                    { "memory.swap.current",
> "memory.memsw.usage_in_bytes" },
> >> +                    { "memory.swap.max", "memory.memsw.limit_in_bytes"
> },
> >> +                    { "memory.kmem.usage_in_bytes",
> "memory.kmem.usage_in_bytes" },
> >> +                    { "memory.kmem.limit_in_bytes",
> "memory.kmem.usage_in_bytes" },
> >> +                    { NULL }
> >> +            },
> >> +      .css_indx = TST_CGROUP_MEMORY
> >> +    },
> >> +    [TST_CGROUP_CPUSET] = { "cpuset", .inner = (items_t){
> >> +                    { "cpuset.cpus", "cpuset.cpus" },
> >> +                    { "cpuset.mems", "cpuset.mems" },
> >> +                    { "cpuset.memory_migrate", "cpuset.memory_migrate"
> },
> >> +                    { NULL }
> >> +            },
> >> +      .css_indx = TST_CGROUP_CPUSET
> >> +    },
> >> +    { NULL }
> >> +};
> >
> > Item is a very generic word, this is a list of known knobs and map
> > between v1 and v2. So maybe cgroup_knob_map or just cgroup_knobs ?
>
> I suppose that cgroup_item can be seperated into just two structs now
> that I removed controller sub items like "memory.swap". This might help
> solve the missing initializer warnings as well.


To separate into two structs sounds good, the 'cgroup_item' contains both
trunk node and controller files make things mess up.


> I would not describe "memory.current" as a knob. It is a read only file
> and I think of knobs as something you can write to. So I would prefer
> cgroup_file and cgroup_subsys.


+1
cgroup_file and cgroup_subsys(or cgroup_controller) all very nice.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210416/de8068fe/attachment-0001.htm>
