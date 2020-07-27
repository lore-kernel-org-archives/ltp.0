From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Jul 2020 01:04:39 +0200
Subject: [LTP] [PATCH v3] Convert chdir01 to the new API
In-Reply-To: <20200727134946.1021-1-mdoucha@suse.cz>
References: <20200727134946.1021-1-mdoucha@suse.cz>
Message-ID: <20200727230439.GA21602@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> chdir02 and chdir03 were removed because the updated chdir01 makes them
> redundant.

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> Changes since v1:
> - Require root privileges and run the test on all file systems
> - Fixed expected return value for directory with 0644 access mode
> - Added test case for chdir("/");
> - Improved chdir() return value/errno checks

> Changes since v2:
> - Dropped chdir02 patch and merged the unprivileged tests into chdir01 instead

Thanks, merged!

Kind regards,
Petr
