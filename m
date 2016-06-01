From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Jun 2016 16:24:26 +0200
Subject: [LTP] [PATCH V3 2/3] syscalls/madvise01: reconstruct and
 convert to new API
In-Reply-To: <1464157779-6883-2-git-send-email-liwang@redhat.com>
References: <1464157779-6883-1-git-send-email-liwang@redhat.com>
 <1464157779-6883-2-git-send-email-liwang@redhat.com>
Message-ID: <20160601142426.GC22372@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* Added needs_root = 1, since both mounting tmpfs and some of the
  madvise flags require it

* Added curly braces around multiline else branch
  (LKML style prefers it that way)

-- 
Cyril Hrubis
chrubis@suse.cz
