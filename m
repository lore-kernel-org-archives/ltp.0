From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 2 Sep 2020 15:38:10 +0530
Subject: [LTP] [PATCH V9 2/2] syscalls/semtimedop: Add failure test for
 invalid timeout pointer
In-Reply-To: <CAEemH2eH6YnKXfVrAQmPGK5zj1x71f=gHZcDUN-QVjZ41F8_6A@mail.gmail.com>
References: <b0d7642a89808c93e059beda06d8519361784686.1597839878.git.viresh.kumar@linaro.org>
 <a9e6d98c722a92d1981fcc2b7ddeba547195c40e.1597839878.git.viresh.kumar@linaro.org>
 <CAEemH2eH6YnKXfVrAQmPGK5zj1x71f=gHZcDUN-QVjZ41F8_6A@mail.gmail.com>
Message-ID: <20200902100810.dka3khkk4gplq22c@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02-09-20, 17:09, Li Wang wrote:
> This '&invalid_to' can't be passed to the semtimedop(.., timeout) correctly,
> because in that wrapper function call_semop(), you invoke
> tst_ts_get(timeout)
> to resolve an invalid address which will be caused a segmental fault
> eventually.

Thanks a lot for figuring out the crash that I wasn't able to solve
then :)

-- 
viresh
