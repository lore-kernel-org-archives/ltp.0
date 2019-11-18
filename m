From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Nov 2019 12:55:42 +0100
Subject: [LTP] [PATCH v2] pan/ltp-pan.c: Add file parsing protection
In-Reply-To: <20191118095858.22067-1-dylan@andestech.com>
References: <20191118095858.22067-1-dylan@andestech.com>
Message-ID: <20191118115542.GA20740@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've added #include <ctype.h> to the patch to have th isspace() defined
and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
