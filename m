From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 24 Jul 2019 11:30:47 +0200
Subject: [LTP] [PATCH 0/2] [RFC] BPF testing
In-Reply-To: <20190724080328.16145-1-rpalethorpe@suse.com>
References: <20190724080328.16145-1-rpalethorpe@suse.com>
Message-ID: <20190724093047.GC4917@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Hello,

> This patch set introduces a very basic test which kicks the tires of the bpf
> system call. It doesn't actually load a eBPF program, I will create another
> test for that. However I have some concerns which I will discuss while doing
> that.
Good start, great.

> There are already extensive BPF tests in the kernel selftests. These appear to
> be quite complex and test a variety of functionality. They also are far less
> structured than LTP's modern tests and are tied to the kernel tree which makes
> using them in QA a pain. There are also some tests in the BCC project, which
> may test the kernel as a byproduct.
Yep, this is true for other tests in kselftest tree.

> So there are a number of options which are not necessarily mutually exclusive:

> 1) Port (some of) the selftests to the LTP.
> 2) Port the LTP library to the selftests.
> 3) Focus the LTP's BPF tests on reproducing specific high impact bugs.

> This patch set copies in the necessary headers so that we have zero external
> dependencies.

> I will also use raw byte code for the program test which is at
> least acceptable for trivial programs. So we do not need BCC or Clang/LLVM
> with eBPF support or matching kernel sources to generate offsets into internal
> structures.
+1

> For the time being atleast my preference would be for (3) while avoiding
> taking on any dependencies to ensure those tests are run by users mostly
> ignorant of BPF, but are still exposed to critical bugs in the BPF stack.
+1

Kind regards,
Petr
