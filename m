From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 23 Jul 2020 13:33:17 +0200
Subject: [LTP] [PATCH] Convert chdir01 to the new API
In-Reply-To: <2b209b61-2bbc-c35f-5704-7b84bab9254d@cn.fujitsu.com>
References: <20200717152450.10787-1-mdoucha@suse.cz>
 <2b209b61-2bbc-c35f-5704-7b84bab9254d@cn.fujitsu.com>
Message-ID: <20200723113317.GA18525@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Honestly speak, I don't like merge chdir02 into chdir01 and we should
> cleanup chdir02 case individually.
chdir02.c tests chdir("/"); and chdir("/tmp"). Not sure whether full path is
more coverage than relative path from chdir01.c.
If we consider these useful, we can just add it into chdir01.c.

Although it looks a bit strange to chroot into root, I'd use just that and avoid
/tmp (it breaks at least for Android with no good reason).

It might makes sense to use .all_filesystems = 1.

> I prefer to merge chdir03 and chdir04 into chdir01 because they are all
> error test.

> Also, when tesing EACCES error,it succeeded.
> tst_test.c:1245: INFO: Timeout per run is 0h 05m 00s
> chdir01.c:68: PASS: chdir("testfile") returns correct value: ENOTDIR (20)
> chdir01.c:68: PASS: chdir("symloop") returns correct value: ELOOP (40)
> chdir01.c:61: FAIL: chdir("keep_out") returned unexpected value 0: SUCCESS
> (0)
Got the same problem on 5.8.0 (on all filesystems).
> chdir01.c:68: PASS: chdir("subdir") returns correct value: SUCCESS (0)
> chdir01.c:68: PASS: chdir(".") returns correct value: SUCCESS (0)
> chdir01.c:68: PASS: chdir("..") returns correct value: SUCCESS (0)
> chdir01.c:68: PASS: chdir("missing") returns correct value: ENOENT (2)

> Best regards
> Yang Xu

Kind regards,
Petr
