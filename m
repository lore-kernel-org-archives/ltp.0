From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Nov 2017 16:44:13 +0100
Subject: [LTP] [RFC PATCH 0/4] Travis enhancements
In-Reply-To: <20171128232130.4843-1-pvorel@suse.cz>
References: <20171128232130.4843-1-pvorel@suse.cz>
Message-ID: <20171129154413.GC15160@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I've added several travis enhancements, most notably added 32bit cross-compile
> build and added more compilers (add gcc-7, clang-4.0, clang-5.0, remove clang-3.9).
> Now there is 12 builds instead of 9, speed increased from ~13 min [1] to ~26 min [2],
> which is maybe to much.  If we don't like it, we can decide which compilers to have.

Well we can cut a few compiler versions, perhaps just keep the latest
for each major number, that should catch most of the problems I guess.

-- 
Cyril Hrubis
chrubis@suse.cz
