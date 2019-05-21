From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 May 2019 15:08:26 +0200
Subject: [LTP] [PATCH v4] syscalls/copy_file_range: add/restructured
	tests
In-Reply-To: <CAOQ4uxi8v+WqwY8sNh+j4b6vYfeyLvHR4+jodt1=s9hUF1FSWQ@mail.gmail.com>
References: <20190506105457.22350-1-camann@suse.com>
 <1ef7d8ee-ae31-b44c-71e6-7d09da55eda2@suse.com>
 <20190506201948.GA9828@dell5510> <20190520143135.GA27341@dell5510>
 <20190520144645.GD28976@rei.lan> <20190520152400.GA11845@dell5510>
 <CAOQ4uxivgpoMeUUxm-fboFfiXLXn+QXNzKJWSHAZhidwUsuvng@mail.gmail.com>
 <20190521114040.GB13910@rei>
 <CAOQ4uxi8v+WqwY8sNh+j4b6vYfeyLvHR4+jodt1=s9hUF1FSWQ@mail.gmail.com>
Message-ID: <20190521130826.GA18812@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > So the glibc fallback code is probably something that will end up being
> > used if someone wants to run application that uses this syscall on BSD
> 
> Or Linux kernel < 4.5.

Linux kernel 4.5 is about two years older than glibc 2.27 that
implements the emulation, so I doubt that someone will actually run this
combination.

-- 
Cyril Hrubis
chrubis@suse.cz
