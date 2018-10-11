From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 11 Oct 2018 15:32:25 +0200
Subject: [LTP] [PATCH v3 2/5] tst_safe_macros: add SAFE_GETGRGID()
In-Reply-To: <20181008071651.16384-1-cfamullaconrad@suse.de>
References: <20181008071651.16384-1-cfamullaconrad@suse.de>
Message-ID: <20181011133224.GA30924@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've split this patch in two, one that adds errno = 0 to getgrnam and
second that adds the SAFE_GETGRGID and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
