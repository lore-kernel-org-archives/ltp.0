From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 May 2016 17:07:29 +0200
Subject: [LTP] [PATCH] waitpid/waitpid10: break test if fork failed
In-Reply-To: <20160425074146.GK17476@localhost.localdomain>
References: <20160413071111.GA26897@localhost.localdomain>
 <20160413123625.GD10941@rei.lan>
 <20160414053923.GH17476@localhost.localdomain>
 <20160419130712.GA21282@rei.lan>
 <20160425074146.GK17476@localhost.localdomain>
Message-ID: <20160512150729.GA1372@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks. Please have a look at this new patch. Thanks in advance.

I've did a few more changes to the test and pushed, thanks.

For instance I've removed the timing parameter since without the alarm
interrupting the test prematurely the test runs for at lest 15 seconds
anyway so the 5 seconds parameter is ignored. And I did that for all
runtest files not just syscalls, etc.

I will also follow up with changing the test to use chekpoints instead
of sleeping for 15 seconds fruitlessly.

-- 
Cyril Hrubis
chrubis@suse.cz
