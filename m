From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Oct 2017 15:02:16 +0200
Subject: [LTP] [PATCH 1/1] uClibc-ng has no profil() support
In-Reply-To: <20171002094403.25417-1-pvorel@suse.cz>
References: <20171002094403.25417-1-pvorel@suse.cz>
Message-ID: <20171002130216.GB1659@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I guess that there may be more libc implementations without profil()
than just uclibc, can we turn this into configure check instead?

-- 
Cyril Hrubis
chrubis@suse.cz
