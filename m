From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Mar 2017 15:37:08 +0200
Subject: [LTP] Out-of-tree build missing some data files.
In-Reply-To: <BN6PR11MB2051C2F128C4DC206D611144CD3F0@BN6PR11MB2051.namprd11.prod.outlook.com>
References: <BN6PR11MB2051C2F128C4DC206D611144CD3F0@BN6PR11MB2051.namprd11.prod.outlook.com>
Message-ID: <20170328133708.GF1045@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> drwxr-xr-x 2 sge sdivmisc 1024 Mar 22 12:50 ext4-ffsb/
> drwxr-xr-x 2 sge sdivmisc   80 Mar 22 12:48 file01/
> drwxr-xr-x 2 sge sdivmisc 1024 Mar 22 12:50 ima_policy/
> drwxr-xr-x 2 sge sdivmisc   80 Mar 22 12:48 ldd01/
> drwxr-xr-x 2 sge sdivmisc 1024 Mar 22 12:49 mc_member/
> drwxr-xr-x 2 sge sdivmisc 1024 Mar 22 12:48 nm01/
> drwxr-xr-x 2 sge sdivmisc   80 Mar 22 12:49 rpc01/
> drwxr-xr-x 3 sge sdivmisc   80 Mar 22 12:50 stress_floppy/
> drwxr-xr-x 2 sge sdivmisc   80 Mar 22 12:48 unzip01/
> 
> but I don't see the datafiles for ld and ar. In the case of ld, the data files are *.c files which I believe are supposed to be installed uncompiled. For ar, the data files are *.in which also need to be installed as is.
> 
> This works for an in-tree build. Bug?

Quite likely this is a problem with the $(wildcard *.c) and
$(wildcard *.in) expressions since these are missing $(abs_srcdir).

Does this work if you change these to $(wildcard $(abs_srcdir)/*.in) and
$(wildcard $(abs_srcdir)/*c) in the ld and ar datafiles/Makefile?

-- 
Cyril Hrubis
chrubis@suse.cz
