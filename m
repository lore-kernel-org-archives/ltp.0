From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Jan 2019 11:24:45 +0100
Subject: [LTP] [RFC PATCH 1/1] Remove ADP tests
In-Reply-To: <CAEemH2fedypj4sJG_fKu4pixac2obxQw5zy=ZapbhieL329rOQ@mail.gmail.com>
References: <20181220150209.5186-1-pvorel@suse.cz>
 <CAEemH2fedypj4sJG_fKu4pixac2obxQw5zy=ZapbhieL329rOQ@mail.gmail.com>
Message-ID: <20190103102444.GA10514@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > They're not used in any runtest, not using shell API.
> 
> Agree, and there is no real update for more than 10 years.

And we have at least two maintained tests that stress proc filesystem,
so there is no value in keeping these scripts.

Acked, Peter go ahead and push this.

-- 
Cyril Hrubis
chrubis@suse.cz
