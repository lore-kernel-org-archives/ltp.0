From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 29 Jul 2019 12:02:17 +0200
Subject: [LTP] [PATCH 0/2] [RFC] BPF testing
In-Reply-To: <20190725142315.GC23135@rei.lan>
References: <20190724080328.16145-1-rpalethorpe@suse.com>
 <20190725142315.GC23135@rei.lan>
Message-ID: <87d0htcg5y.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> This patch set introduces a very basic test which kicks the tires of the bpf
>> system call. It doesn't actually load a eBPF program, I will create another
>> test for that. However I have some concerns which I will discuss while doing
>> that.
>>
>> There are already extensive BPF tests in the kernel selftests. These appear to
>> be quite complex and test a variety of functionality. They also are far less
>> structured than LTP's modern tests and are tied to the kernel tree which makes
>> using them in QA a pain. There are also some tests in the BCC project, which
>> may test the kernel as a byproduct.
>>
>> So there are a number of options which are not necessarily mutually exclusive:
>>
>> 1) Port (some of) the selftests to the LTP.
>> 2) Port the LTP library to the selftests.
>> 3) Focus the LTP's BPF tests on reproducing specific high impact bugs.
>
> The option 3 sounds good, just FYI there are CVEs some with POCs for BPF,
> just by googling "ebpf CVE" you got some:
>
> https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-16995
> https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7308
>
> Also cloudfare blog seems to be very relevant:
>
> https://blog.cloudflare.com/ebpf-cant-count/
>
> And there are some test stuffed in linux/samples/bpf/ as well.

Ah, something I didn't realise is that various types of eBPF program can
be run without CAP_SYS_ADMIN because the man page is out of date. I will
send a patch for that.

--
Thank you,
Richard.
