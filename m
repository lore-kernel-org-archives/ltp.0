From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Apr 2016 17:52:41 +0200
Subject: [LTP] [PATCH] waitpid/waitpid03: break test if fork failed
In-Reply-To: <20160412132256.GA7441@localhost.localdomain>
References: <20160412132256.GA7441@localhost.localdomain>
Message-ID: <20160412155230.GB2917@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -				tst_resm(TFAIL, "cannot open fork #%d", ikids);
> +				tst_brkm(TBROK|TERRNO, cleanup,
> +					 "cannot open fork #%d", ikids);

I guess that we should kill any of the allready sleeping children at this point.

If we move the pid[] array to be global we can create a kill_children()
function to send a signal to all pids in pid[] that are > 0 and call it
if fork fails with SIGKILL as well as from the main loop with the
SIGTERM as well.

-- 
Cyril Hrubis
chrubis@suse.cz
