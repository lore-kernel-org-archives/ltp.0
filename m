From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Dec 2017 13:16:59 +0100
Subject: [LTP] [PATCH v2 4/4] lib: mkfs: use 'mke2fs' for formatting
 extN filesystems
In-Reply-To: <455367801.51525915.1512406356197.JavaMail.zimbra@redhat.com>
References: <20171114021118.103786-1-sspatil@google.com>
 <20171114021118.103786-5-sspatil@google.com>
 <455367801.51525915.1512406356197.JavaMail.zimbra@redhat.com>
Message-ID: <20171206121659.GA19718@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> when you get a chance, can you please also look at this one?
> It's the last unpushed patch from Sandeep's series, that
> touches newly added all_filesystems.

I've looked at it on Monday (and replied). And I think that merging the
tst_supported_fs.c into tst_mkfs.c first would be the best solution
because otherwise we end up with a need to export some kind of API
between these and I do not see a clean solution for that.

-- 
Cyril Hrubis
chrubis@suse.cz
