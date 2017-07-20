From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Jul 2017 13:18:49 +0200
Subject: [LTP] Build error for LTP project
In-Reply-To: <ef80b6fc-deef-375c-99bb-d689ac427ae2@de.bosch.com>
References: <c8ced4c0-637a-3b95-d5e8-5c521b866dba@de.bosch.com>
 <20170720075944.GA20380@rei>
 <ef80b6fc-deef-375c-99bb-d689ac427ae2@de.bosch.com>
Message-ID: <20170720111849.GB32092@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Cleaning the lib directory and building it alone had fixed the problem , 
> however i am quite wondering why this wasn't the case when building from 
> TopSrc Directory itself .

I do not have idea either, for me build for top directory works without
any problems for last few years, hence I suspected a fs corruption. If
you system keeps acting strange I would consider running memtest to
check for faulty RAM, checking underlying storage for errors, etc.

-- 
Cyril Hrubis
chrubis@suse.cz
