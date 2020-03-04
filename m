From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Mar 2020 17:45:21 +0100
Subject: [LTP] [PATCH 1/2] lib: Add safe timerfd macros
In-Reply-To: <dc371963-7dd4-1414-f1c9-19696ffc0124@suse.cz>
References: <20200304151201.19117-1-pvorel@suse.cz>
 <b42e93cb-b06d-538c-a5ff-1d110ed8ce74@suse.cz>
 <dc371963-7dd4-1414-f1c9-19696ffc0124@suse.cz>
Message-ID: <20200304164521.GA5603@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> I forgot to add one more thing: making the return value checks more
> pedantic would also be nice.
I guess you mean if (rval == -1). Sure, I'll do that.

Kind regards,
Petr
