From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 6 Apr 2018 09:08:44 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Add test cmd helper
	tst_test_cmds()
In-Reply-To: <20180406064204.9252-1-pvorel@suse.cz>
References: <20180406064204.9252-1-pvorel@suse.cz>
Message-ID: <20180406070844.dbbedq7c4qso25ct@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> + tst_cmd_available()

> tst_test_cmds() is meant to be a check just for a particular test.
> Works like tst_check_cmds(), but instead of tst_brk() calls tst_res().

> tst_cmd_available() helper can handle cases when command shell builtin
> is not available (e.g. Busybox).

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
...
> +tst_cmd_available()
> +{
> +	if type command > /dev/null 2>&1; then
> +		command -v $1 > /dev/null 2>&1 || return 1
> +	else
> +		which $1 > /dev/null 2>&1 || return 1
Pedantic version would check $? for 127 (indicating which itself it's not found).
Probably worth of adding it.

Kind regards,
Petr
