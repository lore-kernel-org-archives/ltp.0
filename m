From: Li Wang <liwang@redhat.com>
Date: Tue, 26 May 2020 18:01:59 +0800
Subject: [LTP] [PATCH RFC 1/4] lib: add new cgroup test API
In-Reply-To: <1156025603.13595880.1590481651127.JavaMail.zimbra@redhat.com>
References: <20200522012327.18991-1-liwang@redhat.com>
 <1156025603.13595880.1590481651127.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2cGa5tvgWAPbyoanBKh7MbM4kuo+Ws_i0Z2vmbCts1yYQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 26, 2020 at 4:27 PM Jan Stancek <jstancek@redhat.com> wrote:

>
> ----- Original Message -----
>
> > +
> > +/* cgroup v1 */
> > +#define PATH_TMP_CG1_MEM     "/tmp/cgroup1_mem"
> > +#define PATH_TMP_CG1_CST     "/tmp/cgroup1_cpuset"
>
> It's only used for mount, so not sure if making it relative to TMPDIR
> buys us anything.
>

I choose to use /tmp dir just because the cgroup is
mounted temporarily for LTP test and destroyed
after using. And I have no preference to use other
places(i.e. /mnt or /dev).


>
> > +
> > +/* cgroup v1 */
> > +void tst_mount_cgroup1(const char *name, const char *option,
> > +                     const char *mnt_path, const char *new_path)
>
> I'd make all cgroup API start with tst_cgroup*.
>

Good point. I agree to make the function start with that prefix.

The logic in this patch looks like:

tst_cgroup1_mount(...)
tst_cgroup2_mount(...)
// these two API as the basic/internal function for a different version of
cgroup mounting

tst_cgroup1_mem(){
    tst_cgroup1_mount("with mem para")
}
tst_cgroup2_mem(){
    tst_cgroup2_mem("no need set mem, becase v2 has only one heierarchy")
}
// these two API mount different cgroup hierarchy via tst_cgroup*_mount()

tst_cgroup_mem()
{
    //if v1
    tst_cgroup1_mem()
    // if v2
    tst_cgroup2_mem()
}
tst_cgroup_cpu()
{
    // if v1
    tst_cgroup1_cpuset();
    // if v2
    tst_cgroup2_cpuset("no cpuset, skip this invoke");
}
// actully, we only use tst_cgroup_*() in testcase, they as the finial API
to export to



>
> Is the intent to provide API for both v1 and v2, or just higher level API
> that hides the details?
>

The former. My original purpose is to provide unified APIs
for both v1 and v2. Testcase author does not need to care
about the difference of two versions, if he/she want to set
max bytes in tests, just invoke:

//in setup()
    tst_cgroup_mem()
//in main()
    tst_cgroup_mem_set_maxbytes()
//in cleanup()
    tst_cgroup_umount()



>
> > +{
> > +     if (tst_is_mounted(mnt_path))
> > +             goto out;
> > +
> > +     SAFE_MKDIR(mnt_path, 0777);
> > +     if (mount(name, mnt_path, "cgroup", 0, option) == -1) {
> > +             if (errno == ENODEV) {
> > +                     if (rmdir(mnt_path) == -1)
> > +                             tst_res(TWARN | TERRNO, "rmdir %s failed",
> mnt_path);
> > +                     tst_brk(TCONF,
> > +                              "Cgroup v1 is not configured in kernel");
> > +             }
>
> We should probably handle also EBUSY, for cases when controller is already
> part
> of existing hierarchy. E.g. cpu,cpuacct is mounted together, and someone
> tries to mount just cpu:
>   mount("none", "/mnt/cgroup", "cgroup", MS_MGC_VAL, "cpu") = -1 EBUSY
> (Device or resource busy)
>

That's true.

But in general, people are not permitted to use tst_cgroup*_mount()
directly, it is only as the low-level/internal function to hide details we
mount cgroup. My previous thought is that, in v1, cpu,cpuacct are bound
together(as system way) in tst_croup_cpu().



>
> > +
> > +void tst_write_memcg1(long memsz)
>
> This should at least say memmax or something similar, if we add
> functions for more knobs later.
>

Good suggestion.


>
> I'm thinking if it would be worth having API more parametrized,
> something like:
>

Sounds neat, we could have a try and then there
is no need to export too many functions with _mem()
or _cpu() suffixes.

I'd like to merge your method with my original basic
functions, it seems not very hard to achieve patch v2:

tst_cgroup_create(enum tst_cgroup_ctrl ctrl)
{
    tst_cgroup_version();

    switch(ctrl) {
    case TST_CGROUP_MEMCG:
        // if v1
        tst_cgroup1_mount(TST_CGROUP_MEMCG);
        // if v2
        tst_cgroup2_mount()
    break;
    case TST_CGROUP_CPUSET:
          //if v1
          tst_cgroup1_mount(TST_CGROUP_CPUSET);
         // if v2
         TCONF here...
    break;
    }
}



>
> enum tst_cgroup_ctrl {
>         TST_CGROUP_MEMCG = 1,
>         TST_CGROUP_CPUSET = 2,
> };
>
> tst_cgroup_mount(enum tst_cgroup_ctrl)
> tst_cgroup_umount(enum tst_cgroup_ctrl)
>   // tests wouldn't need to use these ones directly
>   // would be probably internal functions
>
> tst_cgroup_version()
>   // to get/check cgroup support in setup()
>
> tst_cgroup_create(enum tst_cgroup_ctrl, const char *dir)
>

Maybe we can drop the second parameter "dir", the mount
functions are internal and we just use path macros in sub-function
which like what I did.



>   // mounts cgroup if not already mounted
>   // creates "dir", sets up subtree_control, etc.
>
> tst_cgroup_cleanup()
>   // cleans up everything, removes dirs, umounts what was mounted
>
> tst_cgroup_move_current(enum tst_cgroup_ctrl, const char *dir)
>   // writes getpid() to dir/"tasks"
>
> tst_cgroup_mem_set_maxbytes(const char *dir, long memsz)
>   // memcg specific function
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200526/d4d6589c/attachment.htm>
