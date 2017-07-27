From: Steve Muckle <smuckle.linux@gmail.com>
Date: Thu, 27 Jul 2017 12:06:24 -0700
Subject: [LTP] [PATCH 1/2] syscalls/epoll_*: allow for epoll_wait
 returning a subset of events
In-Reply-To: <20170727152049.GC32122@rei.lan>
References: <20170715013741.102781-1-smuckle.linux@gmail.com>
 <20170727152049.GC32122@rei.lan>
Message-ID: <47ea5001-223f-9743-edee-6a78f9926265@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On 07/27/2017 08:20 AM, Cyril Hrubis wrote:
>> -	}
>> +		bzero(res_evs, sizeof(res_evs));
> 
> We should remove the initialization of the res_evs array since we are
> clearing it here.

Yep missed that... done.

> 
>> +		res = epoll_wait(epfd, res_evs, 2, -1);
>> +		if (res == -1)
>> +			tst_brk(TBROK | TERRNO, "epoll_wait() fails");
>>   
>> -	if (exp_num == 1) {
>> -		if (!has_event(res_evs, 2, fd[0], EPOLLIN) ||
>> -		    !has_event(res_evs, 2, 0, 0)) {
>> -			tst_res(TFAIL, "epoll_wait() fails to "
>> -				"get expected fd and event");
>> +		if (res == 0) {
>> +			tst_res(TFAIL, "epoll_wait() returns 0, expected %s",
>> +				events == (EPOLLIN|EPOLLOUT) ? "1 or 2" : "1");
>>   			goto end;
>>   		}
>> -	}
>>   
>> -	if (exp_num == 2) {
>> -		if (!has_event(res_evs, 2, fd[0], EPOLLIN) ||
>> -		    !has_event(res_evs, 2, fd[1], EPOLLOUT)) {
>> -			tst_res(TFAIL, "epoll_wait() fails to "
>> -				"get expected fd and event");
>> +		if (res == 1 && (res_evs[1].data.fd || res_evs[1].events)) {
>> +			tst_res(TFAIL,
>> +				"epoll_wait() returns 1 with 2 events");
>> +			goto end;
>> +		}
>> +
>> +		if (has_event(res_evs, 2, fd[0], EPOLLIN)) {
>> +			if (events & EPOLLIN) {
>> +				events &= ~EPOLLIN;
>> +				events_returned++;
>> +			} else {
>> +				tst_res(TFAIL, "epoll_wait() returned %d "
>> +					"and EPOLLIN %x twice", fd[0],
>> +					EPOLLIN);
>> +				goto end;
>> +			}
>> +		}
>> +
>> +		if (has_event(res_evs, 2, fd[1], EPOLLOUT)) {
>> +			if (events & EPOLLOUT) {
>> +				events &= ~EPOLLOUT;
>> +				events_returned++;
>> +			} else {
>> +				tst_res(TFAIL, "epoll_wait() returned %d "
>> +					"and EPOLLOUT %x twice", fd[1],
>> +					EPOLLOUT);
>> +				goto end;
>> +			}
>> +		}
>> +
>> +		if (res != events_returned) {
>> +			tst_res(TFAIL, "epoll_wait() returned %d, expected %d",
>> +				res, events_returned);
> 
> I find this part a bit confusing. The res is actually number of events
> returned from the epoll_wait() while the events_returned is a counter
> for events that were matched correctly.

Yeah I could've named things better.

> So what abou simplifying the logic a bit and doing:
> 
> 	while (events) {
> 		int events_matched = 0;
> 
> 		res = epoll_wait(...);
> 		if (res <= 0) {
> 			tst_res(TFAIL | TERRNO, "epoll_wait() returned %i", res);
> 			goto end;
> 		}
> 
> 		if ((events & EPOLLIN) && has_event(res_evs, 2, fd[0], EPOLLIN)) {
> 			events_matched++;
> 			events &= ~EPOLLIN;
> 		}
> 
> 		//the same for EPOLLOUT
> 
> 		if (res != events_matched) {
> 			tst_res(TFAIL, "Got unexpected events");
> 			//And possibly dump the res_evs here
> 			goto end;
> 		}
> 	}

Sure. Though this does reduce the verbosity/complexity of the error 
handling. I doubt it really matters though...

Thanks for the feedback, v2 on its way.

cheers,
Steve
