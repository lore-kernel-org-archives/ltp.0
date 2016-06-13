From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Jun 2016 17:46:32 +0200
Subject: [LTP] [LTP-20160510] acl_test01: 44: .: test.sh: not found
In-Reply-To: <CAHc6FU45ra6zxEp6NdBC1M4pKOoJYJ16-iRoubXEp1S9QevDhQ@mail.gmail.com>
References: <CA+icZUWdzSCUCPM_91Rg3vk1LNGQ7iuAWVqxbPRcjs5ijKSFaw@mail.gmail.com>
 <20160530142131.GA7416@rei>
 <CA+icZUWRAiAx6bJKNC=Ci6bjR8+jk61ea+xBLcD1Rchu6u7GYg@mail.gmail.com>
 <20160530151115.GA8207@rei.lan>
 <CA+icZUVDvU2JK8AbPn2hVE8QHRUAxmk0k1QHeFgw+Ncsb2V9FA@mail.gmail.com>
 <20160530153220.GB8207@rei.lan>
 <CA+icZUXd0TC36TgYjMDg-6+f-M555C0yu3Pz4R410wutPDNi-A@mail.gmail.com>
 <CA+icZUUm8-L1FDBMZiGdv0CL4Y=4zxj9si-pxtfkne3nG4eqHQ@mail.gmail.com>
 <20160531152139.GB14283@rei.lan>
 <CAHc6FU45ra6zxEp6NdBC1M4pKOoJYJ16-iRoubXEp1S9QevDhQ@mail.gmail.com>
Message-ID: <20160613154632.GB354@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Andreas, please at least CC ltp ML (ltp@lists.linux.it) with patches for
> > LTP testcases, otherwise I cannot apply them.
> 
> here's the fix again; it at least makes the test work on 4.5 and later kernels.

Applied with your signed-of-by.

> > And if you think that testcase is useless or plain wrong just provide
> > reasoning why and I will get rid of it.
> 
> The test seems rather weird. Tu check for (the lack of) "user.*"
> support, it should at least use a "user.*" xattr name that would be
> valid on ther filesystems (any non-empty suffix would do). Likewise
> for system; it could check for "system.posix_acl_access" support, for
> example, but only checking if invalid names are properly rejected
> isn't all that helpful. I don't know what the real idea behind this
> test case was though; the documentation doesn't say much.

Sounds reasonably to me. Feel free to submit a patch that would change
the attrbutes to a valid values.

Also CCing Alexey who seems to be the original author of the test (at
least git log says so).

-- 
Cyril Hrubis
chrubis@suse.cz
