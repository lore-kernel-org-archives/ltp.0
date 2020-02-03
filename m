From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Feb 2020 16:05:04 +0100
Subject: [LTP] [PATCH 1/3] Fix releasing loop devices in shell API
In-Reply-To: <20200129144913.9889-2-mdoucha@suse.cz>
References: <20200129144913.9889-1-mdoucha@suse.cz>
 <20200129144913.9889-2-mdoucha@suse.cz>
Message-ID: <20200203150504.GA15129@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> tst_device helper program currently cannot release any loop devices because
> tst_release_device() checks whether any loop device was acquired by the same
> process. If not, it'll do nothing. And since loop devices for shell test
> scripts are always acquired by a different tst_device process, the check always
> fails.

> Call tst_detach_device() instead to bypass the check.

Indeed losetup --list shows increasing list of the devices.
Thanks for a fix, pushed.

Kind regards,
Petr
