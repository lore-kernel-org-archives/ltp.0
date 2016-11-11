From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 11 Nov 2016 11:59:18 +0300
Subject: [LTP] [PATCH v2 1/3] doc: update networking related
	documentation
In-Reply-To: <20161110115441.17301-1-pvorel@suse.cz>
References: <20161110115441.17301-1-pvorel@suse.cz>
Message-ID: <58258866.1040801@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/10/2016 02:54 PM, Petr Vorel wrote:
> networktests.sh was removed in fddb4f3.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>
> -    iv) Finally, before running the networktests.sh script, two variables must
> -	be set within the script file.  The "RHOST" variable should be set to
> -	the hostname of the server.  The "PASSWD" variable should be set to
> -	root's password on the server machine.  This is necessary for tests
> -	such as telnet01 and ftp01.
> +    iv) Finally, before running the network.sh script, two variables must be
> +   set: The "RHOST" variable should be set to the hostname of the server.  The
> +   "PASSWD" variable should be set to root's password on the server machine.
> +   This is necessary for tests such as telnet01 and ftp01.

Fixed indentation here and pushed the patch-set, thank you.

Best regards,
Alexey

