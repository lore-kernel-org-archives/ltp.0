From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 8 Dec 2017 11:27:37 +0100
Subject: [LTP] [PATCH v3 10/12] getdtablesize01: Handle ENFILE errno
In-Reply-To: <20171204163655.8838-11-punit.agrawal@arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
 <20171204163655.8838-11-punit.agrawal@arm.com>
Message-ID: <20171208102737.GB13286@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	for (loop = 1; loop <= max_val_opfiles; loop++) {
> +	for (loop = 0; ; loop++) {

Why not just for (;;) ?

I do not see that we use the loop variable anywhere in the code.

-- 
Cyril Hrubis
chrubis@suse.cz
