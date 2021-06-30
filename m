From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Jun 2021 11:20:56 +0200
Subject: [LTP] [RFC] Limit the tmpfs size on mounting
In-Reply-To: <CAEemH2da0dOeKpnZZ6+A696gFL+nDAiP7UL9tqm68JH8KO-Qkw@mail.gmail.com>
References: <CAEemH2da0dOeKpnZZ6+A696gFL+nDAiP7UL9tqm68JH8KO-Qkw@mail.gmail.com>
Message-ID: <YNw3ePbVhio3s9JX@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> LTP mount and make use of the whole tmpfs of the test system,
> generally, it's fine. But if a test (e.g fallocate06) try to fill full in
> the
> filesystem, it takes too long to complete testing on a large memory
> system.
> 
> I'm thinking whether we should limit the mount tmpfs size for the
> LTP test, maybe only give 512MB?  but the tricky part for me is to
> add options like "-o size=512M" to prepare_device(), or do some
> additional work for tmpfs mounting.
> 
> and any else way can speed up is also welcome. I'd like to hear
> more advice. Thanks!

I guess that appending '-o size ...' to the mount flags in prepare_device()
is reasonable, but instead of hardcoing the value we should do the same
as we do with the loop devices and the size should be
MAX(tst_test->dev_min_size, DEV_SIZE_MB).

For tmpfs we will do something as:

	...
	const char *mnt_data = tst_test->mnt_data;

	if (!strcmp(dev.fs_type, "tmpfs")) {
		unsigned int dev_size = MAX(tst_test->dev_min_size, DEV_SIZE_MB);

		if (tst_test->mnt_data) {
			snprintf(buf, sizeof(buf), "%s,-o size %uMB",
				 tst_test->mnt_data, dev_size);
		} else {
			snprintf(buf, sizeof(buf), "-o size=%uMB", dev_size);
		}

		tst_res(TINFO, "Limiting tmpfs size to %uMB", dev_size);

		mnt_data = buf;
	}

> # df -Th | grep tmpfs
> Filesystem                             Type      Size  Used Avail Use%
> Mounted on
> devtmpfs                               devtmpfs  126G     0  126G   0% /dev
> tmpfs                                  tmpfs     126G  4.0K  126G   1%
> /dev/shm
> tmpfs                                  tmpfs     126G   18M  126G   1% /run
> tmpfs                                  tmpfs     126G     0  126G   0%
> /sys/fs/cgroup
> /dev/loop0                             tmpfs     126G   23G  104G  18%

Also it looks like should pass something as "ltp-tmpfs" instead of the
"/dev/loopX" string in a case of "tmpfs" filesystem in order not to
confuse people...

-- 
Cyril Hrubis
chrubis@suse.cz
