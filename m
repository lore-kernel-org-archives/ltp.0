From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 Aug 2020 09:17:54 +0200
Subject: [LTP] [PATCH 2/3] IMA: Refactor datafiles directory
In-Reply-To: <20200803184726.2416-3-t-josne@linux.microsoft.com>
References: <20200803184726.2416-1-t-josne@linux.microsoft.com>
 <20200803184726.2416-3-t-josne@linux.microsoft.com>
Message-ID: <20200807071754.GA9748@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lachlan,

> The IMA datafiles directory is structured so that it cannot be directly
> expanded to include datafiles for tests other than `ima_policy.sh`.

> Move the contents of the IMA datafiles directory into an IMA
> datafiles/policy directory.

Why it's required? Can't you use glob for inclusion?

*.policy for valid policies
*.policy-invalid for invalid policies
*.policy* for all policies

BTW I plan to use policies for other tests than just ima_policy.sh

I don't refuse this patch, I just simply don't understand why it's required.

Kind regards,
Petr
