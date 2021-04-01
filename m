From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 1 Apr 2021 08:35:26 +0200
Subject: [LTP] [PATCH] realtime/scripts: Fix indentation error in
 parser.py
In-Reply-To: <20210329181759.4466-1-sturlapati@vmware.com>
References: <20210329181759.4466-1-sturlapati@vmware.com>
Message-ID: <YGVprik5olSjhY+n@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sharan,

> An indentation error in parser.py causes certain blocks
> of code to run even before dependent variables are
> initialized when the code in this file is imported
> by parse-testpi1.py or parse-testpi2.py.

> Post running tests like testpi-2 or testpi-4, the
> results of these tests are parsed and added to the
> logs/ directory. This bug prevents the results of such
> tests from being parsed and thus masks the results of
> these tests.

Thanks for your fix, merged!

It looks to me that 5a8408bc3 changed also whitespace in other files (it was
done by 2to3 script), but these are IMHO correct.

BTW looking into realtime sources, the code is terrible. Not sure how relevant
it is now.

Kind regards,
Petr
