From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Dec 2020 12:26:34 +0100
Subject: [LTP] [PATCH v1] openposix/fork/7-1.c: A bug fix
In-Reply-To: <88B56050-4D68-4B88-B20D-CA7A0711A398@getmailspring.com>
References: <750CB65B-8F87-484D-9373-5CE4E1003413@getmailspring.com>
 <88B56050-4D68-4B88-B20D-CA7A0711A398@getmailspring.com>
Message-ID: <X9NXan8Tql0EDnm8@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> As follow up after chat with Petr Vorel.
> A bug in the test was caused by the line "now = localtime(&nw);" in "output" function, as it sets "errno" variable somewhere.

localtime() shouldn't fail with anything but EOVERFLOW it's a bit
strange to see it fail there.

-- 
Cyril Hrubis
chrubis@suse.cz
