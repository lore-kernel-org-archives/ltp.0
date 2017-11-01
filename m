From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Nov 2017 14:17:21 +0100
Subject: [LTP] [PATCH v3 2/2] lib: keep the test id hidden in LTP library
In-Reply-To: <20171101051523.373-2-liwang@redhat.com>
References: <20171101051523.373-2-liwang@redhat.com>
Message-ID: <20171101131721.GB13757@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes (the tid has to be const, there is no need to
initialize it to NULL, etc.), thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
