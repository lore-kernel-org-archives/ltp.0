From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 13 Jan 2020 13:16:23 +0100
Subject: [LTP] [PATCH v3] Use real FS block size in fallocate05
In-Reply-To: <6f2c4482-9a8f-1b14-be18-10b486576f13@suse.cz>
References: <461386048.17251961.1576663655809.JavaMail.zimbra@redhat.com>
 <20191218131533.15323-1-mdoucha@suse.cz> <20200107152108.GA27182@rei.lan>
 <6f2c4482-9a8f-1b14-be18-10b486576f13@suse.cz>
Message-ID: <e684c55a-5973-af77-ff24-2dfc6a1f67b1@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello, dear Btrfs devs,
we know that you're busy fixing bugs and implementing new features but
could you spare a minute to answer a question that'll help us improve
Btrfs test coverage in LTP?

We'd like to include the improved fallocate() test in the new LTP
release which is planned for early next week. See the question below:

On 1/7/20 4:50 PM, Martin Doucha wrote:
> On 1/7/20 4:21 PM, Cyril Hrubis wrote:
>> Hi!
>>> Changes since v1:
>>> - Increase test device size to 1GB to avoid unrealistic Btrfs edge cases.
>>
>> Do we really need 1GB here? That quadruples the runtime. Aren't we good
>> with just 512MB, that would just double it?
> 
> I guess that's a question for Btrfs devs, so let's ask them.
> 
> We're trying to test fallocate()/write() on various file systems (both
> space allocation and deallocation). What's the minimum block device size
> where Btrfs will use the same code paths as in real-world use cases?
> mkfs.btrfs is called without --mixed.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
