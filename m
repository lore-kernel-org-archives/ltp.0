From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 18:10:17 +0100
Subject: [LTP] [PATCH V2 26/32] crash01: Define _GNU_SOURCE
In-Reply-To: <1452302060-103643-26-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-26-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202171016.GP19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Fixes musl build errors like
> error: 'SA_NOMASK' undeclared (first use in this function)

Here as well, does it work SA_NODEFER?

-- 
Cyril Hrubis
chrubis@suse.cz
