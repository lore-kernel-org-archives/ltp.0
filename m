From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 5 Jun 2020 12:14:43 +0200
Subject: [LTP] [PATCH v2 1/4] lib: add new cgroup test API
In-Reply-To: <CAEemH2ey08M+-ddqh1DNWSOWSi7RNYz8ho=MSPQryYHSqamffg@mail.gmail.com>
References: <20200601100459.32511-1-liwang@redhat.com>
 <1365679659.14324910.1591019831545.JavaMail.zimbra@redhat.com>
 <CAEemH2ffNHY6Ej-Er5a4Ng_9zw+RX+wEBc0widntmYqDLNRqxw@mail.gmail.com>
 <20200602121232.GA22599@janakin.usersys.redhat.com>
 <CAEemH2d7OzG6jBZ15bYGRHm7ry-gVjzuwJYhbHp3yitB3_928w@mail.gmail.com>
 <20200603104314.GA12583@janakin.usersys.redhat.com>
 <CAEemH2ey08M+-ddqh1DNWSOWSi7RNYz8ho=MSPQryYHSqamffg@mail.gmail.com>
Message-ID: <20200605101443.GA6826@janakin.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 03, 2020 at 08:51:37PM +0800, Li Wang wrote:
>> I don't get why global variables are necessary.
>>
>
>The only reason to export them as global variables is to make the legacy
>read/write_cpuse_files() happy. So that I said it is a compromise.
>
>$ git grep tst_cgroup_new_path
>cpuset/cpuset01.c:      write_cpuset_files(tst_cgroup_new_path, "cpus",
>buf);
>cpuset/cpuset01.c:      write_cpuset_files(tst_cgroup_new_path, "mems",
>mems);
>cpuset/cpuset01.c:      write_cpuset_files(tst_cgroup_new_path, "mems",
>buf);
>cpuset/cpuset01.c:      write_cpuset_files(tst_cgroup_new_path, "mems",
>buf);
>lib/mem.c:      write_cpuset_files(tst_cgroup_new_path, "mems", buf);
>lib/mem.c:              write_cpuset_files(tst_cgroup_new_path, "cpus",
>cpus);
>lib/mem.c:              write_cpuset_files(tst_cgroup_new_path, "cpus",
>"0");
>oom/oom04.c:            write_cpuset_files(tst_cgroup_new_path,
>"memory_migrate", "1");
>oom/oom05.c:            write_cpuset_files(tst_cgroup_new_path,
>"memory_migrate", "1");

What if we provided access to it via API? Would we still need these
global variables?

  char *tst_cgroup_get_path(const char *cgroup_mnt)
      // return ptr to tst_cgroup_paths->new_path

mount path is always known to test, because it passes it to tst_cgroup_mount(),
so it just needs to find out "new path".

Would that satisfy the need of this legacy test?

