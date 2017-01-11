From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Jan 2017 15:41:26 +0100
Subject: [LTP] [RFC] [PATCH] safe_macros: Add fallback pwrite() and
 pread() declarations
In-Reply-To: <20170102154707.GA30109@rei.lan>
References: <20170102154707.GA30109@rei.lan>
Message-ID: <20170111144126.GA9518@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I was thinking about this, and I think that we should rather go with a
safer approach, i.e. moving the safe_pread/safe_pwrite into a separate
header. Something as the following patch.

-- 
Cyril Hrubis
chrubis@suse.cz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-safe_macros-Move-SAFE_PREAD-and-SAFE_PWRITE-to-separ.patch
Type: text/x-diff
Size: 6083 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170111/27db3d8b/attachment.patch>
