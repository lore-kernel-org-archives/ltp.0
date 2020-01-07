From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 7 Jan 2020 16:50:43 +0100
Subject: [LTP] [PATCH v3] Use real FS block size in fallocate05
In-Reply-To: <20200107152108.GA27182@rei.lan>
References: <461386048.17251961.1576663655809.JavaMail.zimbra@redhat.com>
 <20191218131533.15323-1-mdoucha@suse.cz> <20200107152108.GA27182@rei.lan>
Message-ID: <6f2c4482-9a8f-1b14-be18-10b486576f13@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1/7/20 4:21 PM, Cyril Hrubis wrote:
> Hi!
>> Changes since v1:
>> - Increase test device size to 1GB to avoid unrealistic Btrfs edge cases.
> 
> Do we really need 1GB here? That quadruples the runtime. Aren't we good
> with just 512MB, that would just double it?

I guess that's a question for Btrfs devs, so let's ask them.

We're trying to test fallocate()/write() on various file systems (both
space allocation and deallocation). What's the minimum block device size
where Btrfs will use the same code paths as in real-world use cases?
mkfs.btrfs is called without --mixed.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
