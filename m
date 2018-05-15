From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 May 2018 13:24:06 +0200
Subject: [LTP] [PATCH 1/1] net/virt_lib.sh: Fix quoting default variable
	on dash
In-Reply-To: <20180515094350.mh6bu2mqajt7vd2n@dell5510>
References: <20180515091626.16121-1-pvorel@suse.cz>
 <20180515094350.mh6bu2mqajt7vd2n@dell5510>
Message-ID: <20180515112406.GB21783@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Dash (and maybe some other posix shells) needs quoting whole argument,
> > otherwise it's not able to assert:
> typo: assigned

Fixed the typo and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
