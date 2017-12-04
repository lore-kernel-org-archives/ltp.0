From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Dec 2017 17:44:22 +0100
Subject: [LTP] [RFC PATCH v2 0/5] Travis enhancements
In-Reply-To: <20171201154641.27407-1-pvorel@suse.cz>
References: <20171201154641.27407-1-pvorel@suse.cz>
Message-ID: <20171204164421.GD21055@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It seems to be rule running only 5 containers at a time, so 11th build slowes
> building about 4 min (18 min vs. 22 min). Which build would you remove?

Well we do the build without any additional libs with gcc-7, we may as
well switch it to clang-3.9 and drop the build with clang-3.9 with the
additional libraries, that way we wouldn't lost much coverage.

-- 
Cyril Hrubis
chrubis@suse.cz
