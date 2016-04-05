From: Cui Bixuan <cuibixuan@huawei.com>
Date: Tue, 5 Apr 2016 19:47:18 +0800
Subject: [LTP] [PATCH] max_map_count: fix error by using runtime check
In-Reply-To: <20160331120726.GB21298@rei.lan>
References: <56DD6138.9060109@huawei.com> <20160322102943.GA10195@rei.suse.cz>
 <56F14D59.1040701@huawei.com> <20160322142842.GE10905@rei.suse.cz>
 <56F259A7.1080908@huawei.com>
 <1242994016.13404335.1458728559657.JavaMail.zimbra@redhat.com>
 <20160331120726.GB21298@rei.lan>
Message-ID: <5703A5C6.3000102@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2016/3/31 20:07, Cyril Hrubis wrote:
> Hi!
>> Can we relax the pass condition to allow map_count to be
>> within some tolerance? Then we wouldn't have to worry so much about
>> all arch specifics.
> 
> Looking at the code we skip exactly one mapping on some architectures.
> So it looks like allowing the number of mappings to be greater by one
> uncoditionally should solve the problem.
> 
> But I'm still undecided if we should go this way as we will weaken the
> test assertion since at the moment we skip exact mappings by their
> label.
I have two ideas:
1. Use strcmp() to replace the strstr() and to check x86_64,x86,ia64,armv7b
and so on.
2. Now we only find the problem in aarch64, we just fix it:

#elif defined(__arm__)
	/* Skip it when run it in aarch64 */
	if(strcmp(un.machine, "aarch64"))
		return false;

	/* Older arm kernels didn't label their vdso maps */
	if (!strncmp(line, "ffff0000-ffff1000", 17))
		return true;

And I think the second is better :-D

Thanks
Cui Bixuan
> 

