From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 May 2019 10:44:27 +0200
Subject: [LTP] [PATCH v4] syscalls/copy_file_range: add/restructured
	tests
In-Reply-To: <20190522190316.GA6781@dell5510>
References: <20190506105457.22350-1-camann@suse.com>
 <1ef7d8ee-ae31-b44c-71e6-7d09da55eda2@suse.com>
 <20190506201948.GA9828@dell5510> <20190520143135.GA27341@dell5510>
 <20190520144645.GD28976@rei.lan> <20190520152400.GA11845@dell5510>
 <CAOQ4uxivgpoMeUUxm-fboFfiXLXn+QXNzKJWSHAZhidwUsuvng@mail.gmail.com>
 <20190521114040.GB13910@rei> <20190522190316.GA6781@dell5510>
Message-ID: <20190523084427.GA30616@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > So the glibc fallback code is probably something that will end up being
> > used if someone wants to run application that uses this syscall on BSD
> > or other corner cases. I guess that we do not care that much about
> > testing the glibc fallback code then.
> OK, we should remove test variants then.

I wouldn't say so, there were real bugs in syscall even in fairly simple
syscall wrappers in glibc, by running the test twice both for the raw
syscall and the glibc wrapper we are testing both the kernel and then
the glibc-kernel integration.

-- 
Cyril Hrubis
chrubis@suse.cz
