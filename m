From: Li Wang <liwang@redhat.com>
Date: Mon, 4 Dec 2017 18:20:43 +0800
Subject: [LTP] Possible bug on tests ksm03, ksm03_1 and ksm05
In-Reply-To: <02937496-8951-60db-05ba-b565346e267e@ti.com>
References: <02937496-8951-60db-05ba-b565346e267e@ti.com>
Message-ID: <CAEemH2d_zxx9-ZZD1PWm_UaSVKKdiq42jiG=u_ZyDTaakos9ng@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Dec 2, 2017 at 6:00 AM, Carlos Hernandez <ceh@ti.com> wrote:
> ksm03, ksm03_1 and ksm05 are reported as failures even though KSM is not
> enabled in kernel config.
> Test does detect KSM configuration is not enabled as shown below:
>
> <<<test_start>>>
> tag=ksm03_1 stime=1511674217
> cmdline="ksm03 -u 128"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:934: [1;34mINFO: [0mTimeout per run is 0h 05m 00s
> ksm03.c:71: [1;33mCONF: [0mKSM configuration is not enabled
> mem.c:761: [1;35mWARN: [0mopen /dev/cgroup/tasks: ENOENT
> mem.c:766: [1;35mWARN: [0mfopen /dev/cgroup/1/tasks: ENOENT
> mem.c:778: [1;35mWARN: [0mrmdir /dev/cgroup/1: ENOENT
> mem.c:780: [1;35mWARN: [0mumount /dev/cgroup: ENOENT
> mem.c:782: [1;35mWARN: [0mrmdir /dev/cgroup: ENOENT


That's because the tests calling cleanup() when get tst_brk() in the
setup() function.

We probably need to skip the umount_mem() in cleanup() since we
do NOT mount it in setup work.

--------
# cat ksm03.c

static void setup(void)
{
    if (access(PATH_KSM, F_OK) == -1)
        tst_brk(TCONF, "KSM configuration is not enabled");
    [...]
}

static void cleanup(void)
{
    [...]
    umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
}


> ksm01                          CONF       32
> ksm01_1                        CONF       32
> ksm02                          CONF       32
> ksm02_1                        CONF       32
> ksm03                          FAIL       36
> ksm03_1                        FAIL       36
> ksm04                          CONF       32
> ksm04_1                        CONF       32
> ksm05                          FAIL       36

Can you also show here what kind of error ksm05 gives to you in the test?



-- 
Li Wang
liwang@redhat.com
