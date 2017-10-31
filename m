From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Oct 2017 12:05:12 +0100
Subject: [LTP] [PATCH 04/18] hugeshmctl01: Fix synchronization issue in
 parent process
In-Reply-To: <20171026141447.26749-5-punit.agrawal@arm.com>
References: <20171026141447.26749-1-punit.agrawal@arm.com>
 <20171026141447.26749-5-punit.agrawal@arm.com>
Message-ID: <20171031110512.GD14550@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +		/* Wait for the child to exit */
> +		if (waitpid(pid_arr[i], &status, 0) != pid_arr[i] &&
> +			!WIFEXITED(status))

Please use SAFE_WAITPID() here, otherwise it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
