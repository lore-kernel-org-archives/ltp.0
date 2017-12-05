From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Dec 2017 09:21:07 +0100
Subject: [LTP] [PATCH v3 12/12] hotplug/cpu_hotplug: Remove bashism
 disown from kill_pid()
In-Reply-To: <20171204163655.8838-13-punit.agrawal@arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
 <20171204163655.8838-13-punit.agrawal@arm.com>
Message-ID: <20171205082107.c3pfhqhtqe7c3kef@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> From: James Morse <james.morse@arm.com>

> disown is a bashism not present in dash. kill_pid() already sends the
> process SIGKILL.

> Remove the "disown" to allow running in shells that don't support
> disown.

> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
Acked-by: Petr Vorel <pvorel@suse.cz>
