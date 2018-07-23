From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Jul 2018 16:42:02 +0200
Subject: [LTP] [PATCH] Add crypto to Makefile
In-Reply-To: <20180723143828.4420-1-rpalethorpe@suse.com>
References: <20180723143828.4420-1-rpalethorpe@suse.com>
Message-ID: <20180723144202.GA5219@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This is missing from my original patch set for the pcrypt_aead01 test. It
> appears that the executable is not installed without it.

Ah, the directories in kernel/Makefile are listed explicitelly, I missed
that as well. Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
