From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 29 Nov 2019 16:25:21 +0100
Subject: [LTP] [PATCH 1/1] Use real FS block size in fallocate05
In-Reply-To: <26933665.14359191.1575028896043.JavaMail.zimbra@redhat.com>
References: <20191128093610.6903-1-mdoucha@suse.cz>
 <20191128093610.6903-2-mdoucha@suse.cz>
 <26933665.14359191.1575028896043.JavaMail.zimbra@redhat.com>
Message-ID: <0e1a3d0e-a154-8469-6e04-a954740a4a61@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/29/19 1:01 PM, Jan Stancek wrote:
>> +			tst_res(TCONF | TTERRNO, "fallocate() not supported");
> 
> tst_brk would make more sense here. If we fail here we can end the test.

No. tst_brk() will terminate the whole test on the first usual test case
(Ext2) and skip all the other file systems that do support fallocate().

> I don't understand why there is need to find minimum value that can
> satisfy this check. It looks like we are testing tst_fill_fs() more
> than fallocate().
> 
> In other words, what is wrong with current test? Is the problem that
> FALLOCATE_SIZE (1M) is not aligned on all platforms? Or is the test
> invalid with FALLOCATE_SIZE that big? Or both?

I don't like to blindly rely on the assumption that block size is always
a power of 2 and smaller than some magic number. Getting the real block
size is trivial. The only real question is how many free blocks do we
allow on a "full" file system in our tests. 1MB is just 16 blocks on
PPC64 so the magic number isn't particularly big anyway.

I've implemented the rest of your suggestions and I'll resubmit later
next week.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
