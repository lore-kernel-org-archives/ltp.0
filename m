From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 18:22:49 +0200
Subject: [LTP] [RFC PATCH v2 1/2] tst_test.sh: Add TST_TEST_DATA and
 TST_TEST_DATA_IFS
In-Reply-To: <20180516161820.3077-2-pvorel@suse.cz>
References: <20180516161820.3077-1-pvorel@suse.cz>
 <20180516161820.3077-2-pvorel@suse.cz>
Message-ID: <20180516162249.s7cmu2mu7mvn4xpy@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> + for consistency the test number is now passed also to functions as the
> '$1' in tests using $TST_CNT in separate functions (so that
> TST_TEST_DATA is always passed as the '$2').
> This is also updated in doc.

To see changes live look bellow:
https://github.com/pevik/ltp/wiki/TEST#231-basic-test-interface


Kind regards,
Petr
