From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 18 Dec 2019 11:01:49 +0100
Subject: [LTP] [PATCH v2] Use real FS block size in fallocate05
In-Reply-To: <8e10a190-128f-cb5b-eeaa-716598411e45@suse.cz>
References: <20191213134002.GE20795@rei.lan>
 <20191217131703.16935-1-mdoucha@suse.cz>
 <1253407522.17207718.1576616558113.JavaMail.zimbra@redhat.com>
 <8e10a190-128f-cb5b-eeaa-716598411e45@suse.cz>
Message-ID: <4f49ce5f-188e-2e68-d99c-5fb89acc30db@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/18/19 10:09 AM, Martin Doucha wrote:
> On 12/17/19 10:02 PM, Jan Stancek wrote:
>> Is there an upstream thread link for that btrfs bug?
> 
> Not yet. I've reported the bug to SUSE Bugzilla for now so that our
> kernel devs can take a closer look. But they may still decide that this
> is expected behavior.

Update: Our kernel devs just said that this is expected behavior. Btrfs
will only release disk space when you deallocate a whole file extent
that can be up to 128MB in size. I'll have to add an exception for Btrfs
to fallocate05 then. Or would you guys prefer to always deallocate the
whole file before the last write() check?

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
