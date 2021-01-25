From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jan 2021 15:30:00 +0100
Subject: [LTP] [PATCH v3 7/7] can: Update contact details
In-Reply-To: <20210120143723.26483-8-rpalethorpe@suse.com>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-8-rpalethorpe@suse.com>
Message-ID: <YA7V6FNZGGma+HiI@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Minus the runtest files that has to be updated the rest looks ok.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Also I do wonder how much of can functionality these tests does not cover.

I guess that we can as well write a test that would add two or more
virtual devices setup routing and send messages between these.

Also there seems to be several different protocols and we seem to be
using only CAN_RAW.

There seems to be also flag to inverse the filter mask with
CAN_INV_FILTER, filter only for error messages and so on.

-- 
Cyril Hrubis
chrubis@suse.cz
