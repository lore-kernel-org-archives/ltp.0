From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Jul 2019 16:23:40 +0200
Subject: [LTP] [PATCH 0/2] [RFC] BPF testing
In-Reply-To: <20190724080328.16145-1-rpalethorpe@suse.com>
References: <20190724080328.16145-1-rpalethorpe@suse.com>
Message-ID: <20190725142315.GC23135@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This patch set introduces a very basic test which kicks the tires of the bpf
> system call. It doesn't actually load a eBPF program, I will create another
> test for that. However I have some concerns which I will discuss while doing
> that.
> 
> There are already extensive BPF tests in the kernel selftests. These appear to
> be quite complex and test a variety of functionality. They also are far less
> structured than LTP's modern tests and are tied to the kernel tree which makes
> using them in QA a pain. There are also some tests in the BCC project, which
> may test the kernel as a byproduct.
> 
> So there are a number of options which are not necessarily mutually exclusive:
> 
> 1) Port (some of) the selftests to the LTP.
> 2) Port the LTP library to the selftests.
> 3) Focus the LTP's BPF tests on reproducing specific high impact bugs.

The option 3 sounds good, just FYI there are CVEs some with POCs for BPF,
just by googling "ebpf CVE" you got some:

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-16995
https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7308

Also cloudfare blog seems to be very relevant:

https://blog.cloudflare.com/ebpf-cant-count/

And there are some test stuffed in linux/samples/bpf/ as well.

-- 
Cyril Hrubis
chrubis@suse.cz
