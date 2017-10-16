From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Oct 2017 12:04:50 +0200
Subject: [LTP] [PATCH 1/1] kernel/ima. Fix compile error regression
In-Reply-To: <20171016095807.17449-1-pvorel@suse.cz>
References: <20171016095807.17449-1-pvorel@suse.cz>
Message-ID: <20171016100450.GA29957@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> introduced in 8b6f0f9a9 ("m4: Fix libcrypto detection on 32-bit cross build")

Sigh, that is a failure I've introduced. Thanks for fixing it, pushed.

-- 
Cyril Hrubis
chrubis@suse.cz
