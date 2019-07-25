From: Steve Muckle <smuckle@google.com>
Date: Thu, 25 Jul 2019 16:55:26 -0700
Subject: [LTP] [PATCH] syscalls/statx01: loosen the stx_blocks check
In-Reply-To: <20190725124844.GB11617@rei.lan>
References: <20190722194439.161904-1-smuckle@google.com>
 <20190723110306.GB22630@rei.lan>
 <1be1f0b8-170a-ac92-b86f-924e2d7f2295@google.com>
 <20190724115735.GC17426@rei.lan>
 <75ded79c-da38-b648-fcfd-a423cc5f0e89@google.com>
 <20190725124844.GB11617@rei.lan>
Message-ID: <e3b3658d-5698-5df5-81c7-d8946457c36a@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 7/25/19 5:48 AM, Cyril Hrubis wrote:
>> Perhaps the x-attributes are spilling out of the inode in some cases and
>> into a data block? I don't know enough about filesystems to say.
> 
> That may be, you can try to list these with getfattr.

This turned out to be because of ext4 per-file encryption which adds 
another x-attr, possibly causing the allocation of another block for 
xattrs. This wasn't apparent initially because the encryption xattr is 
hidden and not reported by getfattr.

I'll send out an updated patch.
